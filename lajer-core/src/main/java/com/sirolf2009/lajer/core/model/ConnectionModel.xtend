package com.sirolf2009.lajer.core.model

import org.eclipse.xtend.lib.annotations.Data

@Data class ConnectionModel {
	
	val PortModel from
	val PortModel to
	
	def static ConnectionModel ->(NodeModel from, PortModel to) {
		return from.outputPorts.get(0).connectTo(to)
	}
	
	def static ConnectionModel ->(PortModel from, NodeModel to) {
		return from.connectTo(to.inputPorts.get(0))
	}
	
	def static ConnectionModel ->(NodeModel from, NodeModel to) {
		return from.connectTo(to)
	}
	
	def static ConnectionModel connectTo(NodeModel from, NodeModel to) {
		return from.outputPorts.get(0).connectTo(to.inputPorts.get(0))
	}
	
	def static ConnectionModel ->(PortModel from, PortModel to) {
		return from.connectTo(to)
	}
	
	def static ConnectionModel connectTo(PortModel from, PortModel to) {
		val connection = new ConnectionModel(from, to)
		from.outgoingConnections += connection
		to.incomingConnections += connection
		return connection
	}
	
}