package com.sirolf2009.lajer.plugin

import com.sirolf2009.lajer.core.LajerCompiler
import com.sirolf2009.lajer.core.LajerModelPersistor
import com.sirolf2009.lajer.core.model.ComponentModel
import com.sirolf2009.lajer.core.model.OperationModel
import com.sirolf2009.lajer.core.model.PortModel
import com.sirolf2009.lajer.core.model.SplitterModel
import com.sirolf2009.lajer.plugin.figure.ConnectionFigure
import com.sirolf2009.lajer.plugin.lajer.LajerManager
import java.io.BufferedReader
import java.io.InputStreamReader
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardOpenOption
import java.util.ArrayList
import java.util.Optional
import org.eclipse.core.resources.IResource
import org.eclipse.core.resources.ResourcesPlugin
import org.eclipse.core.runtime.IProgressMonitor
import org.eclipse.core.runtime.NullProgressMonitor
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
	var Optional<OperationModel> inputFile

	override init(IEditorSite site, IEditorInput input) throws PartInitException {
		this.site = site
		if(input instanceof FileEditorInput) {
			this.input = input
			val in = new BufferedReader(new InputStreamReader(input.file.contents))
			val contents = in.lines.reduce[a, b|a + b]
			in.close()
			inputFile = contents.map[LajerModelPersistor.parseModel(it)]
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
			addKeyListener(new LajerKeylistener(manager))

			inputFile.ifPresent [
				try {
					components.forEach[node|manager.add(node, positions.get(node).key, positions.get(node).value)]
					connections.forEach [ connection |
						val from = manager.nodes.flatMap[outputFigures.filter[port === connection.from]].get(0)
						val to = manager.nodes.flatMap[inputFigures.filter[port === connection.to]].get(0)
						manager.root.add(new ConnectionFigure(to, from))
					]
					inputPorts.forEach [ inputPort |
						val portFigure = manager.nodes.flatMap[inputFigures.filter[port === inputPort]].get(0)
						manager.markAsInput(portFigure)
					]
					outputPorts.forEach [ outputPort |
						val portFigure = manager.nodes.flatMap[outputFigures.filter[port === outputPort]].get(0)
						manager.markAsOutput(portFigure)
					]
				} catch(Exception e) {
					e.printStackTrace()
				}
			]

			lws.contents = contents

			val target = new DropTarget(it, DND.DROP_COPY.bitwiseOr(DND.DROP_NONE).bitwiseOr(DND.DROP_MOVE))
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
					files.forEach [
						val file = ResourcesPlugin.workspace.root.getFileForLocation(Path.fromPortableString(it))
						val javaFile = JavaCore.create(file)
						val project = JavaCore.create(file.project)
						val package = javaFile.parent as PackageFragment
						val type = project.findType(package.names.join(".") + "." + javaFile.elementName.replace(".java", ""))
						javaFile.openable.open(new NullProgressMonitor)
						val nodeType = type.annotations.filter[elementName.equals("Component") || elementName.equals("Splitter")].get(0)
						val exposed = type.methods.filter[!annotations.filter[elementName.equals("Expose")].empty].toList()

						if(nodeType.elementName.equals("Component")) {
							val model = new ComponentModel(type.fullyQualifiedName, new ArrayList(), new ArrayList())
							exposed.map[new PortModel(model, new ArrayList(), new ArrayList())].forEach [
								model.inputPorts.add(it)
								model.outputPorts.add(it)
							]
							manager.add(model, 10, 10)
						} else {
							val model = new SplitterModel(type.fullyQualifiedName, new ArrayList(), new ArrayList())
							if(exposed.size() == 1) {
								model.inputPorts.add(new PortModel(model, new ArrayList(), new ArrayList()))
								model.outputPorts.add(new PortModel(model, new ArrayList(), new ArrayList()))
								model.outputPorts.add(new PortModel(model, new ArrayList(), new ArrayList()))
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
		monitor.beginTask("Saving", 2)
		monitor.subTask("Saving")
		// TODO unify the persistence methods. This is cancer
		LajerModelPersistor.persistModel(manager.asOperation(), Paths.get(editorInput.path.toString).toFile())
		monitor.worked(1)
		monitor.subTask("Compiling")
		Files.write(Paths.get(editorInput.path.toString.replace(".lajer", ".java")), #[LajerCompiler.compile(manager.asOperation())], StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING)
		editorInput.file.parent.refreshLocal(IResource.DEPTH_ONE, new NullProgressMonitor())
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

	override getPartName() {
		return editorInput.file.name
	}

}
