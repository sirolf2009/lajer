package com.sirolf2009.lajer.core.operation.model

import com.sirolf2009.lajer.core.Port
import org.eclipse.xtend.lib.annotations.Data

@Data class Connection {

	val Class<?> dataType	
	val Port from
	val Port to
	
}