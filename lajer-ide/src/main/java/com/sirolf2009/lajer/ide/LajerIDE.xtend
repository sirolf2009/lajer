package com.sirolf2009.lajer.ide

import org.eclipse.swt.SWT
import org.eclipse.swt.layout.GridData
import org.eclipse.swt.layout.GridLayout
import org.eclipse.swt.widgets.DirectoryDialog
import org.eclipse.swt.widgets.Display
import org.eclipse.swt.widgets.Menu
import org.eclipse.swt.widgets.MenuItem
import org.eclipse.swt.widgets.Shell

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
		
		new LajerEditor(shell) => [
			layoutData = new GridData(SWT.FILL, SWT.FILL, true, true)
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
