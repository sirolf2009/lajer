package com.sirolf2009.lajer.core.component

import com.sirolf2009.lajer.core.Lajer
import com.sirolf2009.lajer.core.Port
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class AdaptablePort extends Port {

	val List<Class<?>> parameters
	val Port port	
	
	new(List<Class<?>> parameters, Port port) {
		super(port.component)
		this.parameters = parameters
		this.port = port
	}
	
	override apply(List<Object> params) {
		if(params.size() != parameters.size()) {
			throw new IllegalArgumentException(params+" does not comply with "+parameters)
		} else {
			val newParams = params.indexed.map[
				Lajer.adapterManager.getAdapted(value, parameters.get(key)).orElseGet[value]
			].toList()
			return port.apply(newParams)
		}
	}
	
}