package com.sirolf2009.lajer.core

abstract class JavaBasedNode extends Node {
	
	override String getFullyQualifiedName() {
		return class.name.replace("$", ".")
	}
	
}