package com.sirolf2009.lajer.ide.lajer.command

import com.esotericsoftware.kryo.Kryo
import com.esotericsoftware.kryo.io.Input
import com.sirolf2009.lajer.ide.lajer.LajerManager
import com.sirolf2009.lajer.ide.lajer.LajerState
import com.sirolf2009.lajer.ide.lajer.LajerState.LajerStateSerializer
import java.io.FileInputStream

class LajerCommandLoad extends LajerCommand {
	
	override accept(extension LajerManager manager) {
		val kryo = new Kryo()
		kryo.register(LajerState, new LajerStateSerializer())
		val input = new Input(new FileInputStream(saveFile))
		val state = kryo.readObject(input, LajerState)
		input.close()
		println(state)
	}

	override name() {
		"load"
	}
	
	override author() {
		"sirolf2009"
	}
	
}