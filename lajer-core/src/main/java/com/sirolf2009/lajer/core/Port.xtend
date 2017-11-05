package com.sirolf2009.lajer.core

import com.sirolf2009.lajer.core.operation.model.Connection
import java.util.ArrayList
import java.util.List
import java.util.function.Function
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.Data

@Data abstract class Port implements Function<List<Object>, Object> {
	
	@Accessors val transient List<Connection> incomingConnections = new ArrayList()
	@Accessors val transient List<Connection> outgoingConnections = new ArrayList()
	@Accessors val transient Node component
	
}