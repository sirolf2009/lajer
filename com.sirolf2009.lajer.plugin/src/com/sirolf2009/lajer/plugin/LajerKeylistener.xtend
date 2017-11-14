package com.sirolf2009.lajer.plugin

import com.sirolf2009.lajer.plugin.lajer.LajerManager
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandConnectSelected
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandDisconnectSelected
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMarkSelectedAsInput
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMarkSelectedAsOutput
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedDown
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedLeft
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedRight
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected.LajerCommandMoveSelectedUp
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate.NavigateDown
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate.NavigateLeft
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate.NavigateRight
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate.NavigateUp
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandRemoveSelected
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandSelectFocused
import org.eclipse.swt.SWT
import org.eclipse.swt.events.KeyEvent
import org.eclipse.swt.events.KeyListener

class LajerKeylistener implements KeyListener {
	
	public static val COMMAND_NAVIGATE_UP = new NavigateUp(45)
	public static val COMMAND_NAVIGATE_DOWN = new NavigateDown(45)
	public static val COMMAND_NAVIGATE_LEFT = new NavigateLeft(45)
	public static val COMMAND_NAVIGATE_RIGHT = new NavigateRight(45)
	public static val COMMAND_SELECT_FOCUSED = new LajerCommandSelectFocused()
	public static val COMMAND_REMOVE_SELECTED = new LajerCommandRemoveSelected()
	public static val COMMAND_CONNECT_SELECTED = new LajerCommandConnectSelected()
	public static val COMMAND_DISCONNECT_SELECTED = new LajerCommandDisconnectSelected()
	public static val COMMAND_MARK_SELECTED_AS_INPUT = new LajerCommandMarkSelectedAsInput()
	public static val COMMAND_MARK_SELECTED_AS_OUTPUT = new LajerCommandMarkSelectedAsOutput()
	public static val COMMAND_MOVE_SELECTED_UP = new LajerCommandMoveSelectedUp(10)
	public static val COMMAND_MOVE_SELECTED_DOWN = new LajerCommandMoveSelectedDown(10)
	public static val COMMAND_MOVE_SELECTED_LEFT = new LajerCommandMoveSelectedLeft(10)
	public static val COMMAND_MOVE_SELECTED_RIGHT = new LajerCommandMoveSelectedRight(10)
	public static val COMMAND_MOVE_SELECTED_UP_PRECISE = new LajerCommandMoveSelectedUp(1)
	public static val COMMAND_MOVE_SELECTED_DOWN_PRECISE = new LajerCommandMoveSelectedDown(1)
	public static val COMMAND_MOVE_SELECTED_LEFT_PRECISE = new LajerCommandMoveSelectedLeft(1)
	public static val COMMAND_MOVE_SELECTED_RIGHT_PRECISE = new LajerCommandMoveSelectedRight(1)
	
	val LajerManager manager
	
	var boolean ctrlPressed = false
	var boolean shiftPressed = false
	var boolean altPressed = false
	
	new(LajerManager manager) {
		this.manager = manager
	}
	
	override keyPressed(KeyEvent e) {
		if(e.keyCode == SWT.CTRL) {
			ctrlPressed = true
		} else if(e.keyCode == SWT.SHIFT) {
			shiftPressed = true
		} else if(e.keyCode == SWT.ALT) {
			altPressed = true
		}
		if(ctrlPressed && shiftPressed && e.keyCode == SWT.ARROW_UP) {
			COMMAND_MOVE_SELECTED_UP_PRECISE.accept(manager)
		} else if(ctrlPressed && shiftPressed && e.keyCode == SWT.ARROW_DOWN) {
			COMMAND_MOVE_SELECTED_DOWN_PRECISE.accept(manager)
		} else if(ctrlPressed && shiftPressed && e.keyCode == SWT.ARROW_LEFT) {
			COMMAND_MOVE_SELECTED_LEFT_PRECISE.accept(manager)
		} else if(ctrlPressed && shiftPressed && e.keyCode == SWT.ARROW_RIGHT) {
			COMMAND_MOVE_SELECTED_RIGHT_PRECISE.accept(manager)
		} else if(shiftPressed && e.keyCode == SWT.ARROW_UP) {
			COMMAND_MOVE_SELECTED_UP.accept(manager)
		} else if(shiftPressed && e.keyCode == SWT.ARROW_DOWN) {
			COMMAND_MOVE_SELECTED_DOWN.accept(manager)
		} else if(shiftPressed && e.keyCode == SWT.ARROW_LEFT) {
			COMMAND_MOVE_SELECTED_LEFT.accept(manager)
		} else if(shiftPressed && e.keyCode == SWT.ARROW_RIGHT) {
			COMMAND_MOVE_SELECTED_RIGHT.accept(manager)
		} else if(e.keyCode == SWT.ARROW_LEFT) {
			COMMAND_NAVIGATE_LEFT.accept(manager)
		} else if(e.keyCode == SWT.ARROW_RIGHT) {
			COMMAND_NAVIGATE_RIGHT.accept(manager)
		} else if(e.keyCode == SWT.ARROW_UP) {
			COMMAND_NAVIGATE_UP.accept(manager)
		} else if(e.keyCode == SWT.ARROW_DOWN) {
			COMMAND_NAVIGATE_DOWN.accept(manager)
		} else if(e.keyCode == SWT.CR) {
			COMMAND_SELECT_FOCUSED.accept(manager)
		} else if(e.keyCode == 'c'.charAt(0)) {
			COMMAND_CONNECT_SELECTED.accept(manager)
		} else if(e.keyCode == 'd'.charAt(0)) {
			COMMAND_DISCONNECT_SELECTED.accept(manager)
		} else if(e.keyCode == SWT.DEL) {
			COMMAND_REMOVE_SELECTED.accept(manager)
		} else if(altPressed && e.keyCode == 'i'.charAt(0)) {
			COMMAND_MARK_SELECTED_AS_INPUT.accept(manager)
		} else if(altPressed && e.keyCode == 'o'.charAt(0)) {
			COMMAND_MARK_SELECTED_AS_OUTPUT.accept(manager)
		}
	}
	
	override keyReleased(KeyEvent e) {
		if(e.keyCode == SWT.CTRL) {
			ctrlPressed = false
		} else if(e.keyCode == SWT.SHIFT) {
			shiftPressed = false
		} else if(e.keyCode == SWT.ALT) {
			altPressed = false
		}
	}
	
}