package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.core.operation.model.Connection
import com.sirolf2009.lajer.plugin.figure.ConnectionFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager

class LajerCommandConnectSelected extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(selected.size() > 0) {
			val inputs = selected.filter[isInput].toList()
			val outputs = selected.filter[isOutput].toList()
			inputs.forEach [ input |
				outputs.forEach [ output |
					Connection.connectTo(output.port, input.port)
					manager.root.add(new ConnectionFigure(input, output))
				]
			]
			selected.forEach [
				selected = false
				repaint()
			]
			selected.clear()
			markAsDirty()
		}
	}

	override name() {
		"connect-selected"
	}

	override author() {
		"sirolf2009"
	}

}
