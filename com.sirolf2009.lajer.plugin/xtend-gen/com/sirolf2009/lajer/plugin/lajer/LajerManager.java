package com.sirolf2009.lajer.plugin.lajer;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.operation.model.Operation;
import com.sirolf2009.lajer.core.splitter.Splitter;
import com.sirolf2009.lajer.plugin.LajerEditor;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.NodeFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.figure.SplitterFigure;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandActivateSelected;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandConnectSelected;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandDisconnectSelected;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandMoveSelected;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandNavigate;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommandSelectFocused;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.Label;
import org.eclipse.draw2d.XYLayout;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.KeyEvent;
import org.eclipse.swt.events.KeyListener;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class LajerManager implements KeyListener {
  public final static LajerCommandNavigate.NavigateUp COMMAND_NAVIGATE_UP = new LajerCommandNavigate.NavigateUp(45);
  
  public final static LajerCommandNavigate.NavigateDown COMMAND_NAVIGATE_DOWN = new LajerCommandNavigate.NavigateDown(45);
  
  public final static LajerCommandNavigate.NavigateLeft COMMAND_NAVIGATE_LEFT = new LajerCommandNavigate.NavigateLeft(45);
  
  public final static LajerCommandNavigate.NavigateRight COMMAND_NAVIGATE_RIGHT = new LajerCommandNavigate.NavigateRight(45);
  
  public final static LajerCommandSelectFocused COMMAND_SELECT_FOCUSED = new LajerCommandSelectFocused();
  
  public final static LajerCommandConnectSelected COMMAND_CONNECT_SELECTED = new LajerCommandConnectSelected();
  
  public final static LajerCommandDisconnectSelected COMMAND_DISCONNECT_SELECTED = new LajerCommandDisconnectSelected();
  
  public final static LajerCommandMoveSelected.LajerCommandMoveSelectedUp COMMAND_MOVE_SELECTED_UP = new LajerCommandMoveSelected.LajerCommandMoveSelectedUp(10);
  
  public final static LajerCommandMoveSelected.LajerCommandMoveSelectedDown COMMAND_MOVE_SELECTED_DOWN = new LajerCommandMoveSelected.LajerCommandMoveSelectedDown(10);
  
  public final static LajerCommandMoveSelected.LajerCommandMoveSelectedLeft COMMAND_MOVE_SELECTED_LEFT = new LajerCommandMoveSelected.LajerCommandMoveSelectedLeft(10);
  
  public final static LajerCommandMoveSelected.LajerCommandMoveSelectedRight COMMAND_MOVE_SELECTED_RIGHT = new LajerCommandMoveSelected.LajerCommandMoveSelectedRight(10);
  
  public final static LajerCommandMoveSelected.LajerCommandMoveSelectedUp COMMAND_MOVE_SELECTED_UP_PRECISE = new LajerCommandMoveSelected.LajerCommandMoveSelectedUp(1);
  
  public final static LajerCommandMoveSelected.LajerCommandMoveSelectedDown COMMAND_MOVE_SELECTED_DOWN_PRECISE = new LajerCommandMoveSelected.LajerCommandMoveSelectedDown(1);
  
  public final static LajerCommandMoveSelected.LajerCommandMoveSelectedLeft COMMAND_MOVE_SELECTED_LEFT_PRECISE = new LajerCommandMoveSelected.LajerCommandMoveSelectedLeft(1);
  
  public final static LajerCommandMoveSelected.LajerCommandMoveSelectedRight COMMAND_MOVE_SELECTED_RIGHT_PRECISE = new LajerCommandMoveSelected.LajerCommandMoveSelectedRight(1);
  
  public final static LajerCommandActivateSelected COMMAND_ACTIVATE_SELECTED = new LajerCommandActivateSelected();
  
  private final Canvas canvas;
  
  private final XYLayout layout;
  
  private final Figure root;
  
  private final Map<String, LajerCommand> commands;
  
  private final LajerEditor editor;
  
  private final List<INodeFigure> nodes;
  
  private final Set<PortFigure> selected;
  
  private final Set<PortFigure> inputPorts;
  
  private final Set<PortFigure> outputPorts;
  
  private PortFigure focused;
  
  private boolean ctrlPressed = false;
  
  private boolean shiftPressed = false;
  
  public LajerManager(final Canvas canvas, final XYLayout layout, final Figure root, final LajerEditor editor) {
    this.canvas = canvas;
    this.layout = layout;
    this.root = root;
    this.editor = editor;
    HashMap<String, LajerCommand> _hashMap = new HashMap<String, LajerCommand>();
    this.commands = _hashMap;
    this.register(LajerManager.COMMAND_NAVIGATE_UP);
    this.register(LajerManager.COMMAND_NAVIGATE_DOWN);
    this.register(LajerManager.COMMAND_NAVIGATE_LEFT);
    this.register(LajerManager.COMMAND_NAVIGATE_RIGHT);
    this.register(LajerManager.COMMAND_SELECT_FOCUSED);
    this.register(LajerManager.COMMAND_CONNECT_SELECTED);
    this.register(LajerManager.COMMAND_DISCONNECT_SELECTED);
    this.register(LajerManager.COMMAND_MOVE_SELECTED_UP);
    this.register(LajerManager.COMMAND_MOVE_SELECTED_DOWN);
    this.register(LajerManager.COMMAND_MOVE_SELECTED_LEFT);
    this.register(LajerManager.COMMAND_MOVE_SELECTED_RIGHT);
    this.register(LajerManager.COMMAND_ACTIVATE_SELECTED);
    HashSet<PortFigure> _hashSet = new HashSet<PortFigure>();
    this.selected = _hashSet;
    HashSet<PortFigure> _hashSet_1 = new HashSet<PortFigure>();
    this.inputPorts = _hashSet_1;
    HashSet<PortFigure> _hashSet_2 = new HashSet<PortFigure>();
    this.outputPorts = _hashSet_2;
    ArrayList<INodeFigure> _arrayList = new ArrayList<INodeFigure>();
    this.nodes = _arrayList;
  }
  
  public LajerCommand register(final LajerCommand command) {
    return this.commands.put(command.name(), command);
  }
  
  public NodeFigure add(final Node node) {
    String _name = node.name();
    Label _label = new Label(_name);
    final NodeFigure uml = new NodeFigure(this, node, _label);
    this.nodes.add(uml);
    int _nextInt = new Random().nextInt(1000);
    int _nextInt_1 = new Random().nextInt(800);
    Rectangle _rectangle = new Rectangle(_nextInt, _nextInt_1, (-1), (-1));
    this.layout.setConstraint(uml, _rectangle);
    this.root.add(uml);
    return uml;
  }
  
  public SplitterFigure add(final Splitter splitter) {
    String _name = splitter.name();
    Label _label = new Label(_name);
    final SplitterFigure uml = new SplitterFigure(this, splitter, _label);
    this.nodes.add(uml);
    int _nextInt = new Random().nextInt(1000);
    int _nextInt_1 = new Random().nextInt(800);
    Rectangle _rectangle = new Rectangle(_nextInt, _nextInt_1, (-1), (-1));
    this.layout.setConstraint(uml, _rectangle);
    this.root.add(uml);
    return uml;
  }
  
  @Override
  public void keyPressed(final KeyEvent e) {
    if ((e.keyCode == SWT.CTRL)) {
      this.ctrlPressed = true;
    } else {
      if ((e.keyCode == SWT.SHIFT)) {
        this.shiftPressed = true;
      }
    }
    if (((this.ctrlPressed && this.shiftPressed) && (e.keyCode == SWT.ARROW_UP))) {
      LajerManager.COMMAND_MOVE_SELECTED_UP_PRECISE.accept(this);
    } else {
      if (((this.ctrlPressed && this.shiftPressed) && (e.keyCode == SWT.ARROW_DOWN))) {
        LajerManager.COMMAND_MOVE_SELECTED_DOWN_PRECISE.accept(this);
      } else {
        if (((this.ctrlPressed && this.shiftPressed) && (e.keyCode == SWT.ARROW_LEFT))) {
          LajerManager.COMMAND_MOVE_SELECTED_LEFT_PRECISE.accept(this);
        } else {
          if (((this.ctrlPressed && this.shiftPressed) && (e.keyCode == SWT.ARROW_RIGHT))) {
            LajerManager.COMMAND_MOVE_SELECTED_RIGHT_PRECISE.accept(this);
          } else {
            if ((this.shiftPressed && (e.keyCode == SWT.ARROW_UP))) {
              LajerManager.COMMAND_MOVE_SELECTED_UP.accept(this);
            } else {
              if ((this.shiftPressed && (e.keyCode == SWT.ARROW_DOWN))) {
                LajerManager.COMMAND_MOVE_SELECTED_DOWN.accept(this);
              } else {
                if ((this.shiftPressed && (e.keyCode == SWT.ARROW_LEFT))) {
                  LajerManager.COMMAND_MOVE_SELECTED_LEFT.accept(this);
                } else {
                  if ((this.shiftPressed && (e.keyCode == SWT.ARROW_RIGHT))) {
                    LajerManager.COMMAND_MOVE_SELECTED_RIGHT.accept(this);
                  } else {
                    if ((e.keyCode == SWT.ARROW_LEFT)) {
                      LajerManager.COMMAND_NAVIGATE_LEFT.accept(this);
                    } else {
                      if ((e.keyCode == SWT.ARROW_RIGHT)) {
                        LajerManager.COMMAND_NAVIGATE_RIGHT.accept(this);
                      } else {
                        if ((e.keyCode == SWT.ARROW_UP)) {
                          LajerManager.COMMAND_NAVIGATE_UP.accept(this);
                        } else {
                          if ((e.keyCode == SWT.ARROW_DOWN)) {
                            LajerManager.COMMAND_NAVIGATE_DOWN.accept(this);
                          } else {
                            if ((e.keyCode == SWT.CR)) {
                              LajerManager.COMMAND_SELECT_FOCUSED.accept(this);
                            } else {
                              char _charAt = "c".charAt(0);
                              boolean _equals = (e.keyCode == _charAt);
                              if (_equals) {
                                LajerManager.COMMAND_CONNECT_SELECTED.accept(this);
                              } else {
                                char _charAt_1 = "d".charAt(0);
                                boolean _equals_1 = (e.keyCode == _charAt_1);
                                if (_equals_1) {
                                  LajerManager.COMMAND_DISCONNECT_SELECTED.accept(this);
                                } else {
                                  if ((this.ctrlPressed && (e.keyCode == SWT.F11))) {
                                    LajerManager.COMMAND_ACTIVATE_SELECTED.accept(this);
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  public boolean markAsDirty() {
    return this.editor.markAsDirty();
  }
  
  public Operation asOperation() {
    String _name = this.editor.getEditorInput().getName();
    final Function1<INodeFigure, Node> _function = (INodeFigure it) -> {
      return it.getNode();
    };
    List<Node> _list = IterableExtensions.<Node>toList(ListExtensions.<INodeFigure, Node>map(this.nodes, _function));
    final Function1<PortFigure, Port> _function_1 = (PortFigure it) -> {
      return it.getPort();
    };
    List<Port> _list_1 = IterableExtensions.<Port>toList(IterableExtensions.<PortFigure, Port>map(this.inputPorts, _function_1));
    final Function1<PortFigure, Port> _function_2 = (PortFigure it) -> {
      return it.getPort();
    };
    List<Port> _list_2 = IterableExtensions.<Port>toList(IterableExtensions.<PortFigure, Port>map(this.outputPorts, _function_2));
    return new Operation(_name, _list, _list_1, _list_2);
  }
  
  public void focusOnFirst() {
    this.unfocus();
    int i = 0;
    while (((this.focused == null) && (i < this.nodes.size()))) {
      INodeFigure _get = this.nodes.get(i);
      final Procedure1<INodeFigure> _function = (INodeFigure it) -> {
        boolean _isEmpty = it.getInputFigures().isEmpty();
        boolean _not = (!_isEmpty);
        if (_not) {
          this.focus(it.getInputFigures().get(0));
        } else {
          boolean _isEmpty_1 = it.getOutputFigures().isEmpty();
          boolean _not_1 = (!_isEmpty_1);
          if (_not_1) {
            this.focus(it.getOutputFigures().get(0));
          }
        }
      };
      ObjectExtensions.<INodeFigure>operator_doubleArrow(_get, _function);
    }
  }
  
  public PortFigure unfocus() {
    PortFigure _xifexpression = null;
    if ((this.focused != null)) {
      PortFigure _xblockexpression = null;
      {
        this.focused.setFocused(false);
        this.focused.repaint();
        _xblockexpression = this.focused = null;
      }
      _xifexpression = _xblockexpression;
    }
    return _xifexpression;
  }
  
  public void focus(final PortFigure port) {
    this.unfocus();
    this.focused = port;
    this.focused.setFocused(true);
    this.focused.repaint();
  }
  
  public boolean isInput(final PortFigure port) {
    return (port instanceof InputFigure);
  }
  
  public boolean isOutput(final PortFigure port) {
    return (port instanceof OutputFigure);
  }
  
  @Override
  public void keyReleased(final KeyEvent e) {
    if ((e.keyCode == SWT.CTRL)) {
      this.ctrlPressed = false;
    } else {
      if ((e.keyCode == SWT.SHIFT)) {
        this.shiftPressed = false;
      }
    }
  }
  
  public XYLayout getLayout() {
    return this.layout;
  }
  
  public Figure getRoot() {
    return this.root;
  }
  
  public List<INodeFigure> getNodes() {
    return this.nodes;
  }
  
  public Set<PortFigure> getSelected() {
    return this.selected;
  }
  
  public PortFigure getFocused() {
    return this.focused;
  }
}
