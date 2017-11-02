package com.sirolf2009.lajer.ide.lajer.command

import com.sirolf2009.lajer.ide.lajer.LajerManager

class LajerCommandSelectFocused extends LajerCommand {

	override accept(extension LajerManager manager) {
		if(focused !== null) {
			if(focused.selected) {
				focused.selected = false
				selected.remove(manager.focused)
			} else {
				focused.selected = true
				selected.add(manager.focused)
			}
			focused.repaint()
		}
	}

	override name() {
		"select-focused"
	}

	override author() {
		"sirolf2009"
	}

}
