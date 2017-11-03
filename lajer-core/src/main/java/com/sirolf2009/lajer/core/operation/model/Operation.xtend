package com.sirolf2009.lajer.core.operation.model

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.core.Port
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class Operation extends Node {
	
	val String name
	val List<Node> components
	val List<Port> inputPorts
	val List<Port> outputPorts
	
	override name() {
		name
	}
	
}