package com.sirolf2009.lajer.ide.lajer.command

import com.sirolf2009.lajer.ide.figure.ConnectionFigure
import com.sirolf2009.lajer.ide.lajer.LajerManager

class LajerCommandDisconnectSelected extends LajerCommand {

	override accept(extension LajerManager manager) {
		val inputs = selected.filter[isInput].toList()
		val outputs = selected.filter[isOutput].toList()
		inputs.forEach [ input |
			outputs.forEach [ output |
				val connection = input.port.incomingConnections.filter[from == output.port].findFirst[true]
				if(connection !== null) {
					manager.root.children.removeAll(manager.root.children.filter[it instanceof ConnectionFigure].map[it as ConnectionFigure].filter[it.input == input && it.output == output].toList())
					connection.from.outgoingConnections.remove(connection)
					connection.to.incomingConnections.remove(connection)
				}
			]
		]
		selected.forEach [
			selected = false
			repaint()
		]
		selected.clear()
	}

	override name() {
		"disconnect-selected"
	}

	override author() {
		"sirolf2009"
	}

}
