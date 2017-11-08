package com.sirolf2009.lajer.core

import java.util.List

abstract class Node {
	
	def List<Port> getInputPorts()
	def List<Port> getOutputPorts()
	def String getFullyQualifiedName()
	
	def String getName() {
		fullyQualifiedName.split("\\.").last
	}
	
}