package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.Port
import com.sirolf2009.lajer.core.operation.model.PortComponent
import com.sirolf2009.lajer.core.operation.model.PortOperation
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class LajerThread {

	val Port port
	val List<Object> args

	def start() {
		new Thread [
			port.runPort(args)
		].start()
	}

	def Object runPort(Port port, Object... args) {
		if(port instanceof PortComponent) {
			return port.activateComponent(args)
		} else if(port instanceof PortOperation) {
			return runOperation(port, port.input, args)
		}
	}

	def Object runOperation(PortOperation operationPort, Object... args) {
		val result = operationStep(operationPort, operationPort.input, args)
		return result
	}

	def Object operationStep(PortOperation operationPort, Port port, Object... args) {
		val next = operationPort.operation.connections.filter[from == port].toList()
		val result = port.runPort(args)
		if(next === null || next.size() == 0) { // operation completed
			return result
		} else if(next.size() == 1) { // operation continuing
			return operationStep(operationPort, next.get(0).to, result)
		} else { // operation splitting
			(1 ..< next.size()).forEach [
				new LajerThread(port, args).operationStep(operationPort, next.get(it).to, result)
			]
			return operationStep(operationPort, next.get(0).to, result)
		}
	}

	def Object activateComponent(PortComponent component, Object... args) {
		return component.accept(args)
	}

}
