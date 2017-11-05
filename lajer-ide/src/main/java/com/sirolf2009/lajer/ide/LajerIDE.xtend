package com.sirolf2009.lajer.ide

import com.sirolf2009.lajer.ide.ExampleComponents.Displayer
import com.sirolf2009.lajer.ide.ExampleComponents.Subtractor
import com.sirolf2009.lajer.ide.ExampleComponents.Summer
import com.sirolf2009.lajer.ide.ExampleComponents.UserInput
import com.sirolf2009.lajer.ide.lajer.LajerManager
import java.io.File
import org.eclipse.draw2d.Figure
import org.eclipse.draw2d.LightweightSystem
import org.eclipse.draw2d.XYLayout
import org.eclipse.swt.SWT
import org.eclipse.swt.custom.SashForm
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.layout.GridLayout
import org.eclipse.swt.widgets.Canvas
import org.eclipse.swt.widgets.DirectoryDialog
import org.eclipse.swt.widgets.Display
import org.eclipse.swt.widgets.Menu
import org.eclipse.swt.widgets.MenuItem
import org.eclipse.swt.widgets.Shell
import org.eclipse.swt.widgets.Tree
import org.eclipse.swt.widgets.TreeItem
import com.sirolf2009.lajer.ide.ExampleComponents.EquationChecker

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

		new SashForm(shell, SWT.HORIZONTAL) => [
			layoutData = new GridData(SWT.FILL, SWT.FILL, true, true)
			
			new Canvas(it, SWT.BORDER) => [
				val lws = new LightweightSystem(it)
				val contents = new Figure()
				val contentsLayout = new XYLayout()
				contents.setLayoutManager(contentsLayout)

				val manager = new LajerManager(it, contentsLayout, contents, new File("src/main/resources/Calculator.lajer"))
				addKeyListener(manager)

				val input = manager.add(new UserInput())
				val checker = manager.add(new EquationChecker())
				val summer = manager.add(new Summer())
				val subtractor = manager.add(new Subtractor())
				val displayer = manager.add(new Displayer())

				manager.selected += input.outputFigures.get(0)
				manager.selected += checker.inputFigures.get(0)
				LajerManager.COMMAND_CONNECT_SELECTED.accept(manager)

				manager.selected += checker.outputFigures.get(0)
				manager.selected += summer.inputFigures.get(0)
				LajerManager.COMMAND_CONNECT_SELECTED.accept(manager)

				manager.selected += checker.outputFigures.get(1)
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

			new Tree(it, SWT.SINGLE) => [
				new TreeItem(it, SWT.NONE) => [
					it.text = "Calculator"
					new TreeItem(it, SWT.NONE) => [
						text = "Components"
						new TreeItem(it, SWT.NONE) => [
							text = "UserInput"
						]
						new TreeItem(it, SWT.NONE) => [
							text = "Summer"
						]
						new TreeItem(it, SWT.NONE) => [
							text = "Subtractor"
						]
						new TreeItem(it, SWT.NONE) => [
							text = "Displayer"
						]
					]
					new TreeItem(it, SWT.NONE) => [
						text = "Operations"
						new TreeItem(it, SWT.NONE) => [
							text = "Main"
						]
					]
				]
			]
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
