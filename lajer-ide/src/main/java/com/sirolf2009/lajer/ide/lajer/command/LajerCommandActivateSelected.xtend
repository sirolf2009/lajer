package com.sirolf2009.lajer.ide.lajer.command

import com.sirolf2009.lajer.core.operation.LajerThread
import com.sirolf2009.lajer.ide.figure.InputFigure
import com.sirolf2009.lajer.ide.lajer.LajerManager

class LajerCommandActivateSelected extends LajerCommand {
	
	override accept(extension LajerManager manager) {
		if(focused !== null && focused instanceof InputFigure) {
			new LajerThread(focused.port, #[]).start()
		}
	}
	
	override name() {
		"activate-selected"
	}
	
	override author() {
		"sirolf2009"
	}
	
}