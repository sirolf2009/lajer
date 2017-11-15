package com.sirolf2009.lajer.core.component

import com.sirolf2009.lajer.core.Port
import java.lang.invoke.MethodHandle
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class ProducerPort extends Port {
	
	val MethodHandle handle
	
	override apply(List<Object> args) {
		if(args.size() > 0 && args.filter[it !== null].size() > 0) {
			throw new IllegalArgumentException(handle+" does not accept arguments: "+args)
		}
		return handle.invokeWithArguments(newArrayList())
	}
	
}