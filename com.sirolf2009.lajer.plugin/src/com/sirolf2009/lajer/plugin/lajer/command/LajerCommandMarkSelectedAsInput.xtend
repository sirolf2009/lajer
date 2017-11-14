package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.figure.InputFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager

class LajerCommandMarkSelectedAsInput extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null && focused.isInput) {
			markAsInput(focused as InputFigure)
		}
	}
	
}
