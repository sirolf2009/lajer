package com.sirolf2009.lajer.core.splitter

import com.sirolf2009.lajer.core.Node
import org.eclipse.xtend.lib.annotations.Data

@Data abstract class Splitter extends Node {
	
	val splitterPort = getSplitterPort()
	val truePort = new DummyPort(this)
	val falsePort = new DummyPort(this)
	
	override final getInputPorts() {
		return #[splitterPort]
	}
	
	def abstract SplitterPort getSplitterPort()
	
	override getOutputPorts() {
		return #[truePort, falsePort]
	}
	
	override name() {
		return class.simpleName
	}
	
}