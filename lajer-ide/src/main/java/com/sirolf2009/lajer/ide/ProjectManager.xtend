package com.sirolf2009.lajer.ide

import java.io.File
import org.eclipse.xtend.lib.annotations.Data

class ProjectManager {
	
	@Data static class ProjectDescription {
		
		val File pom
		
	}
	
}