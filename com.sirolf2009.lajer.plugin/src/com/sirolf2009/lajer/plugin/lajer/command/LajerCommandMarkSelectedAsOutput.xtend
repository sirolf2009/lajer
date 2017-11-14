package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.figure.OutputFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager

class LajerCommandMarkSelectedAsOutput extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null && focused.isOutput) {
			markAsOutput(focused as OutputFigure)
		}
	}
	
}
