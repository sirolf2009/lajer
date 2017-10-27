package com.sirolf2009.lajer.core.operation.model

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.core.Port
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class Operation extends Node {
	
	val List<Node> components
	val List<Port> componentPorts
	val List<Connection> connections
	
	override getPorts() {
		return componentPorts.map[new PortOperation(this, it) as Port].toList()
	}
	
}