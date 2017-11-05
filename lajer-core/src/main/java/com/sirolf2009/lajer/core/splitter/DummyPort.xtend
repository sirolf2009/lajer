package com.sirolf2009.lajer.core.splitter

import com.sirolf2009.lajer.core.Port
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

@Data class DummyPort extends Port {
	
	override apply(List<Object> t) {
		throw new IllegalArgumentException("Dummy ports cannot act as input")
	}
	
}