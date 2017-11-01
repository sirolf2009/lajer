package com.sirolf2009.lajer.core.operation

import com.sirolf2009.lajer.core.Port
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
		val result = port.apply(args)
		if(port.outgoingConnections.size() == 1) {
			port.outgoingConnections.get(0).to.runPort(#[result])
		} else if(port.outgoingConnections.size() > 1) {
			(1 ..< port.outgoingConnections.size()).forEach [
				new Thread [
					new LajerThread(port, args).runPort(port.outgoingConnections.get(it).to, #[result])
				].start()
			]
			port.outgoingConnections.get(0).to.runPort(#[result])
		}
	}

}
