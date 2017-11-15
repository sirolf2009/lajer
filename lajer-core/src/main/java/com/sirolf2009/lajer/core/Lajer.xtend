package com.sirolf2009.lajer.core

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Optional
import java.util.HashMap
import java.util.function.Function

class Lajer {
	
	@Accessors static val adapterManager = new AdapterManager()
	
	static class AdapterManager {
		
		val adapters = new HashMap<Pair<Class<?>, Class<?>>, Function<Object, Object>>
		
		def Optional<Object> getAdapted(Object adaptableObject, Class<?> adapterType) {
			if(adapters.containsKey(adaptableObject.class -> adapterType)) {
				return Optional.of(adapters.get(adaptableObject.class -> adapterType).apply(adaptableObject))
			} else {
				return Optional.empty()
			}
		}
		
		def registerAdapter(Class<?> a, Class<?> b, Function<Object, Object> adapter) {
			adapters.put(a -> b, adapter)
		}
		
	}
	
}