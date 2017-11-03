package com.sirolf2009.lajer.ide.lajer.command

import com.sirolf2009.lajer.ide.lajer.LajerManager
import com.esotericsoftware.kryo.Kryo
import com.esotericsoftware.kryo.io.Output
import java.io.FileOutputStream
import com.sirolf2009.lajer.ide.lajer.LajerState
import com.sirolf2009.lajer.ide.lajer.LajerState.LajerStateSerializer

class LajerCommandSave extends LajerCommand {
	
	override accept(extension LajerManager manager) {
		val kryo = new Kryo()
		kryo.register(LajerState, new LajerStateSerializer())
		val output = new Output(new FileOutputStream(saveFile))
		kryo.writeObject(output, asState())
		output.close()
	}

	override name() {
		"save"
	}
	
	override author() {
		"sirolf2009"
	}
	
}