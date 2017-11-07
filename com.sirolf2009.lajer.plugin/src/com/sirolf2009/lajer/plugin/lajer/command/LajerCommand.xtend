package com.sirolf2009.lajer.plugin.lajer.command

import com.sirolf2009.lajer.plugin.lajer.LajerManager
import java.util.function.Consumer

abstract class LajerCommand implements Consumer<LajerManager> {

	def abstract String name()
	def abstract String author()	
	
}