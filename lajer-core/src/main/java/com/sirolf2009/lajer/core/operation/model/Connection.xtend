package com.sirolf2009.lajer.core.operation.model

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.core.Port
import org.eclipse.xtend.lib.annotations.Data

@Data class Connection {

	val Port from
	val Port to
	
	def static Connection ->(Node from, Node to) {
		return from.connectTo(to)
	}
	
	def static Connection connectTo(Node from, Node to) {
		return from.outputPorts.get(0).connectTo(to.inputPorts.get(0))
	}
	
	def static Connection ->(Port from, Port to) {
		return from.connectTo(to)
	}
	
	def static Connection connectTo(Port from, Port to) {
		val connection = new Connection(from, to)
		from.outgoingConnections += connection
		to.incomingConnections += connection
		return connection
	}
	
}