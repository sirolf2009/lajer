package com.sirolf2009.lajer.core.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import org.eclipse.xtend.lib.annotations.ToString

@FinalFieldsConstructor @ToString @Accessors class SplitterModel extends NodeModel {
	
	def getSplitterPort() {
		return inputPorts.get(0)
	}
	
	def getTruePort() {
		return outputPorts.get(0)
	}
	
	def getFalsePort() {
		return outputPorts.get(1)
	}
	
}