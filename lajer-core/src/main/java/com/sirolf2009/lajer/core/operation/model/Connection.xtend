package com.sirolf2009.lajer.core.operation.model

import com.sirolf2009.lajer.core.Port
import org.eclipse.xtend.lib.annotations.Data

@Data class Connection {

	val Port from
	val Port to
	
	def static Connection connectTo(Port from, Port to) {
		val connection = new Connection(from, to)
		from.outgoingConnections += connection
		to.incomingConnections += connection
		return connection
	}
	
}