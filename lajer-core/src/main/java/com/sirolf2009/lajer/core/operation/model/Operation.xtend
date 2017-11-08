package com.sirolf2009.lajer.core.operation.model

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.core.Port
import java.util.List
import java.util.stream.Collectors
import java.util.stream.Stream
import org.eclipse.xtend.lib.annotations.Data

@Data class Operation extends Node {
	
	val String fullyQualifiedName
	val List<Node> components
	val List<Port> inputPorts
	val List<Port> outputPorts
	
	def getConnections() {
		return components.stream().flatMap[
			Stream.concat(it.inputPorts.stream().flatMap[incomingConnections.stream()], it.outputPorts.stream().flatMap[outgoingConnections.stream()])
		].collect(Collectors.toSet())
	}
	
}