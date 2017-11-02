package com.sirolf2009.lajer.ide.lajer.command

import com.sirolf2009.lajer.ide.lajer.LajerManager
import java.util.function.Function
import java.util.stream.Stream
import org.eclipse.draw2d.geometry.Point
import org.eclipse.xtend.lib.annotations.Data

@Data abstract class LajerCommandNavigate extends LajerCommand {

	val Function<Double, Boolean> withinAngle

	override accept(extension LajerManager manager) {
		if(focused === null) {
			focusOnFirst()
		} else {
			val me = focused.bounds.center
			nodes.parallelStream().flatMap [
				Stream.concat(inputFigures.stream(), outputFigures.stream())
			].filter[it !== manager.focused].filter [
				return withinAngle.apply(me.getAngle(bounds.center))
			].min [ a, b |
				Math.abs(a.bounds.center.getDistance(me)).compareTo(b.bounds.center.getDistance(me))
			].ifPresent [
				focus(it)
			]
		}
	}

	def getAngle(Point a, Point b) {
		val angle = Math.toDegrees(Math.atan2(b.y - a.y, b.x - a.x))
		return if(angle >= 0) angle else angle + 360
	}
	
	public static class NavigateUp extends LajerCommandNavigate {

		new(int losRange) {
			super([it > 270 - losRange && it < 270 - losRange])
		}
		
		override name() {
			"navigate-up"
		}
		
		override author() {
			"sirolf2009"
		}

	}
	
	public static class NavigateRight extends LajerCommandNavigate {

		new(int losRange) {
			super([it > 360 - losRange || it < losRange])
		}
		
		override name() {
			"navigate-right"
		}
		
		override author() {
			"sirolf2009"
		}

	}
	
	public static class NavigateDown extends LajerCommandNavigate {

		new(int losRange) {
			super([it > 90 - losRange && it < 90 - losRange])
		}
		
		override name() {
			"navigate-down"
		}
		
		override author() {
			"sirolf2009"
		}

	}
	
	public static class NavigateLeft extends LajerCommandNavigate {

		new(int losRange) {
			super([it > 180 - losRange && it < 180 - losRange])
		}
		
		override name() {
			"navigate-left"
		}
		
		override author() {
			"sirolf2009"
		}

	}

}
