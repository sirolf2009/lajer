package com.sirolf2009.lajer.core.model

import java.util.List
import java.util.Map
import java.util.stream.Collectors
import java.util.stream.Stream
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

@FinalFieldsConstructor @Accessors class OperationModel extends NodeModel {
	
	val List<NodeModel> components
	val Map<NodeModel, Pair<Integer, Integer>> positions
	
	def getConnections() {
		return components.stream().flatMap[
			Stream.concat(it.inputPorts.stream().flatMap[incomingConnections.stream()], it.outputPorts.stream().flatMap[outgoingConnections.stream()])
		].collect(Collectors.toSet())
	}
	
}