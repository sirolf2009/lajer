package com.sirolf2009.lajer.plugin

import com.sirolf2009.lajer.plugin.ExampleComponents.Displayer
import com.sirolf2009.lajer.plugin.ExampleComponents.EquationChecker
import com.sirolf2009.lajer.plugin.ExampleComponents.Subtractor
import com.sirolf2009.lajer.plugin.ExampleComponents.Summer
import com.sirolf2009.lajer.plugin.ExampleComponents.UserInput
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import org.eclipse.core.runtime.IProgressMonitor
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.LightweightSystem
import org.eclipse.draw2d.XYLayout
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.Canvas
import org.eclipse.swt.widgets.Composite
import org.eclipse.ui.IEditorInput
import org.eclipse.ui.IEditorSite
import org.eclipse.ui.PartInitException
import org.eclipse.ui.part.EditorPart
import org.eclipse.ui.part.FileEditorInput
import com.sirolf2009.lajer.core.LajerCompiler
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardOpenOption

class LajerEditor extends EditorPart {

	var LajerManager manager

	override init(IEditorSite site, IEditorInput input) throws PartInitException {
		this.site = site
		if(input instanceof FileEditorInput) {
			this.input = input
		} else {
			throw new IllegalArgumentException("Invalid input " + input)
		}
	}

	override createPartControl(Composite parent) {
		new Canvas(parent, SWT.BORDER) => [
			val lws = new LightweightSystem(it)
			val contents = new Figure()
			val contentsLayout = new XYLayout()
			contents.setLayoutManager(contentsLayout)

			manager = new LajerManager(it, contentsLayout, contents, this)
			addKeyListener(manager)

			manager.add(new UserInput())
			manager.add(new EquationChecker())
			manager.add(new Summer())
			manager.add(new Subtractor())
			manager.add(new Displayer())

			lws.contents = contents
		]
	}

	override setFocus() {
	}

	override doSave(IProgressMonitor monitor) {
		monitor.beginTask("Saving", 1)
		val generated = LajerCompiler.compile("com.sirolf2009", manager.asOperation())
		Files.write(Paths.get(editorInput.path.toString.replace(".lajer", ".java")), #[generated], StandardOpenOption.CREATE)
		monitor.done()
	}

	override doSaveAs() {
	}

	override isDirty() {
		return true
	}

	override isSaveAsAllowed() {
		return true
	}

	override FileEditorInput getEditorInput() {
		super.getEditorInput() as FileEditorInput
	}

}
