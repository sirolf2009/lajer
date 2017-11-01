package com.sirolf2009.lajer.ide.xtend

import org.eclipse.swt.SWT
import org.eclipse.swt.custom.StyleRange
import org.eclipse.swt.events.KeyEvent
import org.eclipse.swt.events.KeyListener
import org.eclipse.swt.widgets.Display
import org.eclipse.swt.custom.StyledText

class XtendFormatter implements KeyListener {

	static val keywords = #[
		"package",
		"import",
		"class",
		"enum",
		"interface",
		"public",
		"private",
		"protected",
		"synchronized",
		"final",
		"static",
		"volatile",
		"default",
		"override",
		"new",
		"super",
		"val",
		"var",
		"if",
		"else",
		"do",
		"while",
		"for"
	]

	val StyleRange styleKeyword

	new(Display display) {
		this(new StyleRange() => [
			foreground = display.getSystemColor(SWT.COLOR_BLUE)
			fontStyle = SWT.BOLD
		])
	}

	new(StyleRange styleKeyword) {
		this.styleKeyword = styleKeyword
	}

	override keyPressed(KeyEvent e) {
	}

	override keyReleased(KeyEvent e) {
		keywords.forEach [
			val widget = e.widget as StyledText
			var index = widget.text.indexOf(it)
			while(index != -1) {
				widget.setStyleRanges(0, 0, #[index, length()], #[styleKeyword])
				index = widget.text.indexOf(it, index + 1)
			}
		]
	}

}
