package com.sirolf2009.lajer.core.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import org.eclipse.xtend.lib.annotations.ToString

@FinalFieldsConstructor @ToString @Accessors class PortModel {
	
	@Accessors transient val NodeModel component
	@Accessors transient val List<ConnectionModel> incomingConnections
	@Accessors transient val List<ConnectionModel> outgoingConnections
	
}