package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.figure.ConnectionFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.draw2d.IFigure

class LajerCommandRemoveSelected extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null) {
			val incomingConnections = focused.node.inputFigures.flatMap [ input |
				input.port.incomingConnections.map[it]
			].toSet()
			incomingConnections.forEach [
				manager.root.children.removeAll(manager.root.children.filter[it instanceof ConnectionFigure].map[it as ConnectionFigure].filter[it.input == input && it.output == output].toList())
				from.outgoingConnections.remove(it)
				to.incomingConnections.remove(it)
			]
			val outgoingConnections = focused.node.outputFigures.flatMap [ output |
				output.port.outgoingConnections.map[it]
			]
			outgoingConnections.forEach [
				manager.root.children.removeAll(manager.root.children.filter[it instanceof ConnectionFigure].map[it as ConnectionFigure].filter[it.input == input && it.output == output].toList())
				from.outgoingConnections.remove(it)
				to.incomingConnections.remove(it)
			]

			manager.nodes.remove(focused.node)
			manager.root.remove(focused.node as IFigure)
			manager.unfocus()
			manager.root.repaint()
			manager.markAsDirty()
		}
	}

}
