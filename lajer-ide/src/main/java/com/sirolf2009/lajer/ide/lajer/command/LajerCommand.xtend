package com.sirolf2009.lajer.ide.lajer.command

import java.util.function.Consumer
import com.sirolf2009.lajer.ide.lajer.LajerManager

abstract class LajerCommand implements Consumer<LajerManager> {

	def abstract String name()
	def abstract String author()	
	
}