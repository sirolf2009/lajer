package com.sirolf2009.lajer.plugin

import java.io.File
import org.eclipse.ui.IEditorInput
import org.eclipse.xtend.lib.annotations.Data

@Data class LajerInput implements IEditorInput {
	
	val File file
	
	override exists() {
		return file.exists()
	}
	
	override getImageDescriptor() {
	}
	
	override getName() {
		return file.name
	}
	
	override getPersistable() {
	}
	
	override getToolTipText() {
		"tooltip"
	}
	
	override <T> getAdapter(Class<T> adapter) {
	}
	
}