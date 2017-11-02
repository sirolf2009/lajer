package com.sirolf2009.lajer.ide

import com.sirolf2009.lajer.ide.LajerEditor.Summer
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.Label
import org.eclipse.draw2d.LightweightSystem
import org.eclipse.draw2d.XYLayout
import org.eclipse.draw2d.geometry.Rectangle
import org.eclipse.swt.SWT
import org.eclipse.swt.events.KeyEvent
import org.eclipse.swt.events.KeyListener
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.layout.GridLayout
import org.eclipse.swt.widgets.Canvas
import org.eclipse.swt.widgets.DirectoryDialog
import org.eclipse.swt.widgets.Display
import org.eclipse.swt.widgets.Menu
import org.eclipse.swt.widgets.MenuItem
import org.eclipse.swt.widgets.Shell
import com.sirolf2009.lajer.ide.lajer.LajerManager
import com.sirolf2009.lajer.ide.model.NodeFigure
import com.sirolf2009.lajer.ide.LajerEditor.Subtractor

class LajerIDE {

	def static void main(String[] args) {
		val display = new Display()
		val shell = new Shell(display)
		shell.layout = new GridLayout(1, true)
		shell.text = "Lajer"

		shell.menuBar = new Menu(shell, SWT.BAR) => [
			new MenuItem(it, SWT.CASCADE) => [
				text = "File"
				menu = new Menu(shell, SWT.DROP_DOWN) => [
					new MenuItem(it, SWT.PUSH) => [
						addListener(SWT.Selection, [
							val dialog = new DirectoryDialog(shell)
							println(dialog.open())
						])
						text = "Open Project\t"
						accelerator = SWT.MOD1 + SWT.MOD2 + ('o'.charAt(0))
					]
					new MenuItem(it, SWT.PUSH) => [
						addListener(SWT.Selection, [shell.dispose()])
						text = "Exit\t"
						accelerator = SWT.MOD1 + ('q'.charAt(0))
					]
				]
			]
		]

//		new LajerEditor(shell) => [
//			layoutData = new GridData(SWT.FILL, SWT.FILL, true, true)
//		]
		new Canvas(shell, SWT.BORDER) => [
			layoutData = new GridData(SWT.FILL, SWT.FILL, true, true)
			
			val lws = new LightweightSystem(it)
			val contents = new Figure()
			val contentsLayout = new XYLayout()
			contents.setLayoutManager(contentsLayout)
			
			val manager = new LajerManager(it, contentsLayout, contents)
			addKeyListener(manager)
			manager.add(new Summer())
			manager.add(new Subtractor())
			
			lws.contents = contents
		]

		shell.maximized = true
		shell.open()
		while(!shell.isDisposed()) {
			if(!display.readAndDispatch()) {
				display.sleep()
			}
		}
		display.dispose()
	}

}
