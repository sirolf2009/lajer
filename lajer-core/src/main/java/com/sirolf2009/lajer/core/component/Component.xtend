package com.sirolf2009.lajer.core.component

import com.sirolf2009.lajer.core.JavaBasedNode
import com.sirolf2009.lajer.core.Port
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data abstract class Component extends JavaBasedNode {
	
	val ports = getPorts()
	def protected List<Port> getPorts()
	
	override getInputPorts() {
		return ports
	}
	
	override getOutputPorts() {
		return ports
	}
	
}