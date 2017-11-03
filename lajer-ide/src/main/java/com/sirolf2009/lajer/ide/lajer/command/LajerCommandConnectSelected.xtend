package com.sirolf2009.lajer.ide.lajer.command

import com.sirolf2009.lajer.core.operation.model.Connection
import com.sirolf2009.lajer.ide.lajer.LajerManager
import com.sirolf2009.lajer.ide.model.ConnectionFigure

class LajerCommandConnectSelected extends LajerCommand {

	override accept(extension LajerManager manager) {
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
	}

	override name() {
		"connect-selected"
	}

	override author() {
		"sirolf2009"
	}

}
