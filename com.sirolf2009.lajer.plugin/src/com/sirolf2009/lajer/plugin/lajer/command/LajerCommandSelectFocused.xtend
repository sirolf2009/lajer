package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.lajer.LajerManager

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

}