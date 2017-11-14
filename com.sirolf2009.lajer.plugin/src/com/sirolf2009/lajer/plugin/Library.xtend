package com.sirolf2009.lajer.plugin

import org.eclipse.jdt.core.IPackageFragmentRoot
import org.eclipse.jdt.core.IType
import org.eclipse.jdt.core.JavaCore
import org.eclipse.swt.SWT
import org.eclipse.swt.dnd.DND
import org.eclipse.swt.dnd.DragSource
import org.eclipse.swt.dnd.DragSourceEvent
import org.eclipse.swt.dnd.DragSourceListener
import org.eclipse.swt.dnd.FileTransfer
import org.eclipse.swt.widgets.Composite
import org.eclipse.swt.widgets.Table
import org.eclipse.swt.widgets.TableItem
import org.eclipse.ui.IFileEditorInput
import org.eclipse.ui.IPartListener
import org.eclipse.ui.IWorkbenchPart
import org.eclipse.ui.PlatformUI
import org.eclipse.ui.part.ViewPart

class Library extends ViewPart implements IPartListener {

	var Table library

	override createPartControl(Composite parent) {
		library = new Table(parent, SWT.V_SCROLL) => [
			new DragSource(it, DND.DROP_COPY.bitwiseOr(DND.DROP_NONE).bitwiseOr(DND.DROP_MOVE)) => [
				transfer = #[FileTransfer.instance]
				addDragListener(new DragSourceListener() {
					override dragFinished(DragSourceEvent arg0) {
					}

					override dragSetData(DragSourceEvent event) {
						val node = library.selection.get(0).data as IType
						val data = newArrayOfSize(1)
						data.set(0, project.getFile(node.path.removeFirstSegments(1)).rawLocationURI.toURL.path)
						event.data = data
					}

					override dragStart(DragSourceEvent arg0) {
					}
				})
			]
		]
		PlatformUI.workbench.activeWorkbenchWindow.activePage.addPartListener(this)
		updateNodeList()
	}

	def updateNodeList() {
		library.remove(0, library.itemCount-1)
		library.redraw()
		try {
			nodes.forEach [ node |
				new TableItem(library, SWT.NONE) => [
					text = node.fullyQualifiedName
					data = node
				]
			]
		} catch(Exception e) {
		}
		library.redraw()
	}

	def getNodes() {
		val project = JavaCore.create(project)
		project.packageFragments.filter[
			kind == IPackageFragmentRoot.K_SOURCE
		].flatMap [
			compilationUnits.flatMap[allTypes.toList()]
		].filter[it.annotations.filter[elementName.equals("Component") || elementName.equals("Splitter")].size() > 0]
	}

	def getProject() {
		val editor = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().getActiveEditor()
		val input = editor.getEditorInput() as IFileEditorInput
		val file = input.getFile()
		file.getProject()
	}

	override setFocus() {
		library.setFocus()
	}

	override partActivated(IWorkbenchPart part) {
		if(part instanceof LajerEditor) {
			updateNodeList()
		}
	}

	override partBroughtToTop(IWorkbenchPart part) {
	}

	override partClosed(IWorkbenchPart part) {
	}

	override partDeactivated(IWorkbenchPart part) {
	}

	override partOpened(IWorkbenchPart part) {
	}

}
