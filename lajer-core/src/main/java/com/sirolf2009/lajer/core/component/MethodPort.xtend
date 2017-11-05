package com.sirolf2009.lajer.core.component

import com.sirolf2009.lajer.core.Port
import java.lang.invoke.MethodHandle
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class MethodPort extends Port {
	
	val MethodHandle handle
	
	override apply(List<Object> args) {
		return handle.invokeWithArguments(args)
	}
	
}