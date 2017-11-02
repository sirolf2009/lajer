package com.sirolf2009.lajer.ide.lajer

import com.sirolf2009.lajer.core.Node
import com.sirolf2009.lajer.ide.model.NodeFigure
import com.sirolf2009.lajer.ide.model.PortFigure
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Random
import java.util.Set
import java.util.function.Predicate
import java.util.stream.Stream
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.XYLayout
import org.eclipse.draw2d.geometry.Point
import org.eclipse.draw2d.geometry.Rectangle
import org.eclipse.swt.SWT
import org.eclipse.swt.events.KeyEvent
import org.eclipse.swt.events.KeyListener
import org.eclipse.swt.widgets.Canvas

class LajerManager implements KeyListener {

	static val ARROW_KEYS = #[SWT.ARROW_UP, SWT.ARROW_RIGHT, SWT.ARROW_DOWN, SWT.ARROW_LEFT]

	val Canvas canvas
	val XYLayout layout
	val Figure root
	val List<NodeFigure> nodes
	val Set<PortFigure> selected
	var PortFigure focused
	var ctrlPressed = false

	new(Canvas canvas, XYLayout layout, Figure root) {
		this.canvas = canvas
		this.layout = layout
		this.root = root
		selected = new HashSet()
		nodes = new ArrayList()
	}

	def add(Node node) {
		val uml = new NodeFigure(this, node, new Label(node.class.simpleName))
		nodes += uml
		layout.setConstraint(uml, new Rectangle(new Random().nextInt(1000), new Random().nextInt(1000), -1, -1))
		root.add(uml)
	}

	static val losRange = 45
	override keyPressed(KeyEvent e) {
		if(ARROW_KEYS.contains(e.keyCode)) {
			if(focused === null) {
				focusOnFirst()
			} else {
				val me = focused.bounds.center
				val Predicate<PortFigure> lineOfSightPredicate = {
					if(e.keyCode == SWT.ARROW_LEFT) {
						[
							val angle = me.getAngle(bounds.center)
							return angle > 180-losRange && angle < 180+losRange
						]
					} else if(e.keyCode == SWT.ARROW_RIGHT) {
						[
							val angle = me.getAngle(bounds.center)
							return angle > 360-losRange || angle < losRange
						]
					} else if(e.keyCode == SWT.ARROW_UP) {
						[
							val angle = me.getAngle(bounds.center)
							return angle > 260-losRange && angle < 260+losRange
						]
					} else {
						[
							val angle = me.getAngle(bounds.center) 
							return angle > 90-losRange && angle < 90+losRange
						]
					}
				}
				nodes.parallelStream().flatMap [
					Stream.concat(inputFigures.stream(), outputFigures.stream())
				].filter[it !== focused].filter(lineOfSightPredicate).min [ a, b |
					Math.abs(a.bounds.center.getDistance(me)).compareTo(b.bounds.center.getDistance(me))
				].ifPresent [
					focus(it)
				]
			}
		} else if(e.keyCode == SWT.CR) {
			if(focused !== null) {
				focused.selected = !focused.selected
				focused.repaint()
			}
		}
		
		if(e.keyCode == SWT.CTRL) {
			ctrlPressed = true
		}
	}

	def getAngle(Point a, Point b) {
		val angle = Math.toDegrees(Math.atan2(b.y - a.y, b.x - a.x))
		return if(angle >= 0) angle else angle+360 
	}

	def focusOnFirst() {
		unfocus()
		var i = 0
		while(focused === null && i < nodes.size()) {
			nodes.get(i) => [
				if(!inputFigures.isEmpty()) {
					inputFigures.get(0).focus()
				} else if(!outputFigures.isEmpty()) {
					outputFigures.get(0).focus()
				}
			]
		}
	}

	def unfocus() {
		if(focused !== null) {
			focused.focused = false
			focused.repaint()
			focused = null
		}
	}

	def focus(PortFigure port) {
		unfocus()
		focused = port
		focused.focused = true
		focused.repaint()
	}

	override keyReleased(KeyEvent e) {
		if(e.keyCode == SWT.CTRL) {
			ctrlPressed = false
		}
	}

}
