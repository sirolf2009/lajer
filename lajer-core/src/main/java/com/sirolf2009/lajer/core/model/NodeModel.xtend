package com.sirolf2009.lajer.core.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import org.eclipse.xtend.lib.annotations.ToString

@FinalFieldsConstructor @ToString @Accessors class NodeModel {
	
	val String fullyQualifiedName
	val List<PortModel> inputPorts
	val List<PortModel> outputPorts
	
	def String getName() {
		fullyQualifiedName.split("\\.").last
	}
	
}