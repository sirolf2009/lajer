package com.sirolf2009.lajer.ide

import com.sirolf2009.lajer.ide.ExampleComponents.Subtractor
import com.sirolf2009.lajer.ide.ExampleComponents.Summer
import com.sirolf2009.lajer.ide.lajer.LajerManager
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.LightweightSystem
import org.eclipse.draw2d.XYLayout
import org.eclipse.swt.SWT
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.layout.GridLayout
import org.eclipse.swt.widgets.Canvas
import org.eclipse.swt.widgets.DirectoryDialog
import org.eclipse.swt.widgets.Display
import org.eclipse.swt.widgets.Menu
import org.eclipse.swt.widgets.MenuItem
import org.eclipse.swt.widgets.Shell
import com.sirolf2009.lajer.ide.ExampleComponents.UserInput
import com.sirolf2009.lajer.ide.ExampleComponents.Displayer

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
		
		new Canvas(shell, SWT.BORDER) => [
			layoutData = new GridData(SWT.FILL, SWT.FILL, true, true)
			
			val lws = new LightweightSystem(it)
			val contents = new Figure()
			val contentsLayout = new XYLayout()
			contents.setLayoutManager(contentsLayout)
			
			val manager = new LajerManager(it, contentsLayout, contents)
			addKeyListener(manager)
			
			val input = manager.add(new UserInput())
			val summer = manager.add(new Summer())
			val subtractor = manager.add(new Subtractor())
			val displayer = manager.add(new Displayer())
			
			manager.selected += input.outputFigures.get(0)
			manager.selected += summer.inputFigures.get(0)
			LajerManager.COMMAND_CONNECT_SELECTED.accept(manager)
			
			manager.selected += input.outputFigures.get(0)
			manager.selected += subtractor.inputFigures.get(0)
			LajerManager.COMMAND_CONNECT_SELECTED.accept(manager)
			
			manager.selected += summer.outputFigures.get(0)
			manager.selected += displayer.inputFigures.get(0)
			LajerManager.COMMAND_CONNECT_SELECTED.accept(manager)
			
			manager.selected += subtractor.outputFigures.get(0)
			manager.selected += displayer.inputFigures.get(0)
			LajerManager.COMMAND_CONNECT_SELECTED.accept(manager)
			
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
