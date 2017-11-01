package com.sirolf2009.lajer.core.component

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.core.Port
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data abstract class Component extends Node {
	
	val ports = getPorts()
	def protected List<Port> getPorts()
	
	override getInputPorts() {
		return ports
	}
	
	override getOutputPorts() {
		return ports
	}
	
}