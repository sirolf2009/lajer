package com.sirolf2009.lajer.core.splitter

import java.lang.invoke.MethodHandle
import java.util.List
import org.eclipse.xtend.lib.annotations.Data
import com.sirolf2009.lajer.core.component.FunctionPort

@Data class SplitterPort extends FunctionPort {
	
	new(Splitter splitter, MethodHandle handle) {
		super(splitter, handle.verifyReturn())
	}
	
	override Boolean apply(List<Object> args) {
		super.apply(args) as Boolean
	}
	
	def private static verifyReturn(MethodHandle handle) {
		if(handle.type.returnType != Boolean && handle.type.returnType != boolean) {
			throw new IllegalArgumentException("Splitters may only return boolean!")
		} else {
			return handle
		}
	}
	
	override Splitter getComponent() {
		super.getComponent() as Splitter
	}
	
	def Splitter getSplitter() {
		return getComponent()
	}
	
}