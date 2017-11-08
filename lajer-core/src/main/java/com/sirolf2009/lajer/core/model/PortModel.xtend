package com.sirolf2009.lajer.core.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class PortModel {
	
	val NodeModel component
	val List<ConnectionModel> incomingConnections
	val List<ConnectionModel> outgoingConnections
	
}