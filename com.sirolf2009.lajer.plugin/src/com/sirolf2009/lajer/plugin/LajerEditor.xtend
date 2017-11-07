package com.sirolf2009.lajer.plugin

import com.sirolf2009.lajer.core.LajerCompiler
import com.sirolf2009.lajer.plugin.ExampleComponents.Displayer
import com.sirolf2009.lajer.plugin.ExampleComponents.EquationChecker
import com.sirolf2009.lajer.plugin.ExampleComponents.Subtractor
import com.sirolf2009.lajer.plugin.ExampleComponents.Summer
import com.sirolf2009.lajer.plugin.ExampleComponents.UserInput
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardOpenOption
import org.eclipse.core.runtime.IProgressMonitor
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.LightweightSystem
import org.eclipse.draw2d.XYLayout
import org.eclipse.swt.SWT
import org.eclipse.swt.dnd.DND
import org.eclipse.swt.dnd.DropTarget
import org.eclipse.swt.dnd.DropTargetEvent
import org.eclipse.swt.dnd.DropTargetListener
import org.eclipse.swt.dnd.FileTransfer
import org.eclipse.swt.widgets.Canvas
import org.eclipse.swt.widgets.Composite
import org.eclipse.ui.IEditorInput
import org.eclipse.ui.IEditorSite
import org.eclipse.ui.IFileEditorInput
import org.eclipse.ui.PartInitException
import org.eclipse.ui.part.EditorPart
import org.eclipse.ui.part.FileEditorInput
import org.eclipse.core.resources.ResourcesPlugin
import org.eclipse.core.runtime.Path
import org.eclipse.jdt.core.search.SearchEngine
import org.eclipse.jdt.core.JavaCore
import org.eclipse.jdt.internal.core.PackageFragment

class LajerEditor extends EditorPart {

	var LajerManager manager
	var Canvas canvas
	var boolean dirty = false

	override init(IEditorSite site, IEditorInput input) throws PartInitException {
		this.site = site
		if(input instanceof FileEditorInput) {
			this.input = input
		} else {
			throw new IllegalArgumentException("Invalid input " + input)
		}
	}	

	override createPartControl(Composite parent) {
		new Canvas(parent, SWT.NONE) => [
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

			val target = new DropTarget(it, DND.DROP_NONE)
			target.transfer = #[FileTransfer.instance]
			target.addDropListener(new DropTargetListener() {

				override dragEnter(DropTargetEvent arg0) {
				}

				override dragLeave(DropTargetEvent arg0) {
				}

				override dragOperationChanged(DropTargetEvent arg0) {
				}

				override dragOver(DropTargetEvent arg0) {
				}

				override drop(DropTargetEvent event) {
					val files = event.data as String[]
					files.forEach[
						val file = ResourcesPlugin.workspace.root.getFileForLocation(Path.fromPortableString(it))
						val javaFile = JavaCore.create(file)
						val project = JavaCore.create(file.project)
						val package = javaFile.parent as PackageFragment
						val type = project.findType(package.names.join(".")+"."+javaFile.elementName.replace(".java", ""))
						println(type.methods.join("\n"))
					]
				}

				override dropAccept(DropTargetEvent arg0) {
				}

			})
		]
	}

	override setFocus() {
		canvas?.setFocus()
	}

	override doSave(IProgressMonitor monitor) {
		monitor.beginTask("Saving", 1)
		val generated = LajerCompiler.compile("com.sirolf2009", manager.asOperation())
		Files.write(Paths.get(editorInput.path.toString.replace(".lajer", ".java")), #[generated], StandardOpenOption.CREATE)
		monitor.done()
	}

	override doSaveAs() {
	}

	def markAsDirty() {
		dirty = true
	}

	override isDirty() {
		return dirty
	}

	override isSaveAsAllowed() {
		return true
	}

	override FileEditorInput getEditorInput() {
		super.getEditorInput() as FileEditorInput
	}
	
}
