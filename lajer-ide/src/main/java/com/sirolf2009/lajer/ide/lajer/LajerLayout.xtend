package com.sirolf2009.lajer.ide.lajer

import java.util.Map
import org.eclipse.swt.SWT
import org.eclipse.swt.graphics.Point
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Control
import org.eclipse.swt.widgets.Layout
import org.eclipse.xtend.lib.annotations.Data
import com.sirolf2009.lajer.ide.lajer.LajerLayout.LajerLayoutData
import org.eclipse.swt.graphics.Rectangle

class LajerLayout extends Layout {

	var Map<Control, Rectangle> cache

	override protected computeSize(Composite composite, int wHint, int hHint, boolean flushCache) {
		if(flushCache || cache === null || cache.size() != composite.children.size()) {
			cache = composite.children.calculateSizeLocations()
		}
		val maxX = cache.values.map[x].max()
		val maxY = cache.values.map[y].max()
		return new Point(maxX, maxY)
	}

	override protected layout(Composite composite, boolean flushCache) {
		if(flushCache || cache === null || cache.size() != composite.children.size()) {
			cache = composite.children.calculateSizeLocations()
		}
		composite.children.forEach[
			bounds = cache.get(it)
		]
	}

	def calculateSizeLocations(Control[] children) {
		children.map [
			val size = computeSize(SWT.DEFAULT, SWT.DEFAULT, true)
			if(layoutData !== null && layoutData instanceof LajerLayoutData) {
				val data = layoutData as LajerLayoutData
				return it -> new Rectangle(data.x, data.y, size.x, size.y)
			} else {
				return it -> new Rectangle(0, 0, size.x, size.y)
			}
		].toMap([key], [value])
	}

	@Data public static class LajerLayoutData {

		val int x
		val int y

	}

}
