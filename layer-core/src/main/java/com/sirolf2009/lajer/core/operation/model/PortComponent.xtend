package com.sirolf2009.lajer.core.operation.model

import com.sirolf2009.lajer.core.Port
import com.sirolf2009.lajer.core.component.Component
import java.lang.invoke.MethodHandle
import org.eclipse.xtend.lib.annotations.Data

@Data class PortComponent extends Port {
	
	val Component component
	val MethodHandle handle
	
	override accept(Object... args) {
		return handle.invokeWithArguments(args)
	}
	
}