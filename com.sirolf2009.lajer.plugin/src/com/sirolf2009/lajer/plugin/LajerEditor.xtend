package com.sirolf2009.lajer.plugin

import com.sirolf2009.lajer.core.LajerCompiler
import com.sirolf2009.lajer.core.model.ComponentModel
import com.sirolf2009.lajer.core.model.PortModel
import com.sirolf2009.lajer.core.model.SplitterModel
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardOpenOption
import java.util.ArrayList
import org.eclipse.core.resources.ResourcesPlugin
import org.eclipse.core.runtime.IProgressMonitor
import org.eclipse.core.runtime.Path
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.LightweightSystem
import org.eclipse.draw2d.XYLayout
import org.eclipse.jdt.core.JavaCore
import org.eclipse.jdt.internal.core.PackageFragment
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
import org.eclipse.ui.PartInitException
import org.eclipse.ui.part.EditorPart
import org.eclipse.ui.part.FileEditorInput

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
						val nodeType = type.annotations.filter[elementName.equals("Component") || elementName.equals("Splitter")].get(0)
						val exposed = type.methods.filter[!annotations.filter[elementName.equals("Expose")].empty].toList()
						
						if(nodeType.elementName.equals("Component")) {
							val model = new ComponentModel(type.fullyQualifiedName, new ArrayList(), new ArrayList())
							exposed.map[new PortModel(model, new ArrayList(), new ArrayList())].forEach[
								model.inputPorts += it
								model.outputPorts += it
							]
							manager.add(model, 10, 10)
						} else {
							val model = new SplitterModel(type.fullyQualifiedName, new ArrayList(), new ArrayList())
							if(exposed.size() == 1) {
								model.inputPorts += new PortModel(model, new ArrayList(), new ArrayList())
								model.outputPorts += new PortModel(model, new ArrayList(), new ArrayList())
								model.outputPorts += new PortModel(model, new ArrayList(), new ArrayList())
							} else {
								throw new RuntimeException("Only one method may be exposed for a splitter")
							}
							manager.add(model, 10, 10)
						}
						markAsDirty()
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
		monitor.subTask("Saving")
		
		monitor.subTask("Compiling")
		val generated = LajerCompiler.compile(manager.asOperation())
		Files.write(Paths.get(editorInput.path.toString.replace(".lajer", ".java")), #[generated], StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING)
		monitor.done()
		dirty = false
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
