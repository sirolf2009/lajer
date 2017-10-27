package com.sirolf2009.lajer.core.operation.model

import com.sirolf2009.lajer.core.Port
import org.eclipse.xtend.lib.annotations.Data

@Data class PortOperation extends Port {
	
	val Operation operation
	val Port input
	
	override accept(Object... args) {
		return input.accept(args)
	}
	
}