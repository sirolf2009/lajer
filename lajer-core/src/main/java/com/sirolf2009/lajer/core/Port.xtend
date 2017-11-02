package com.sirolf2009.lajer.core

import com.sirolf2009.lajer.core.component.Component
import com.sirolf2009.lajer.core.operation.model.Connection
import java.lang.invoke.MethodHandle
import java.util.ArrayList
import java.util.List
import java.util.function.Function
import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.xtend.lib.annotations.Accessors

@Data class Port implements Function<List<Object>, Object> {
	
	@Accessors val transient Component component
	val MethodHandle handle
	val List<Connection> incomingConnections = new ArrayList()
	val List<Connection> outgoingConnections = new ArrayList()
	
	override apply(List<Object> args) {
		return handle.invokeWithArguments(args)
	}
	
}