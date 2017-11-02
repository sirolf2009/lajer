package com.sirolf2009.lajer.ide.lajer.command

import com.sirolf2009.lajer.core.operation.model.Connection
import com.sirolf2009.lajer.ide.lajer.LajerManager

class LajerCommandConnectSelected extends LajerCommand {

	override accept(extension LajerManager manager) {
		val inputs = selected.filter[isInput].toList()
		val outputs = selected.filter[isOutput].toList()
		inputs.forEach [ input |
			outputs.forEach [ output |
				Connection.connectTo(input.port, output.port)
				// TODO draw connection
			]
		]
		selected.forEach [
			selected = false
			repaint()
		]
		selected.clear()
	}

	override name() {
		"connect-selected"
	}

	override author() {
		"sirolf2009"
	}

}
