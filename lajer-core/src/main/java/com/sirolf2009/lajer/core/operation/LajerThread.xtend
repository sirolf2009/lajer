package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.Port
import com.sirolf2009.lajer.core.operation.model.Connection
import com.sirolf2009.lajer.core.splitter.SplitterPort
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class LajerThread {

	val Port port
	val List<Object> args

	def start() {
		new Thread [
			run()
		].start()
	}

	def run() {
		port.runPort(args)
	}

	def void runPort(Port port, List<Object> args) {
		if(port instanceof SplitterPort) {
			runSplitterPort(port, args)
		} else {
			propagate(#[port.apply(args)], port.outgoingConnections)
		}
	}

	def runSplitterPort(SplitterPort port, List<Object> args) {
		val result = port.apply(args)
		if(result) {
			propagate(args, port.component.truePort.outgoingConnections)
		} else {
			propagate(args, port.component.falsePort.outgoingConnections)
		}
	}

	def propagate(List<Object> args, List<Connection> connections) {
		if(connections.size() == 1) {
			connections.get(0).to.runPort(args)
		} else if(connections.size() > 1) {
			(1 ..< connections.size()).forEach [
				new Thread [
					new LajerThread(connections.get(it).from, args).runPort(connections.get(it).to, args)
				].start()
			]
			connections.get(0).to.runPort(args)
		}
	}

}
