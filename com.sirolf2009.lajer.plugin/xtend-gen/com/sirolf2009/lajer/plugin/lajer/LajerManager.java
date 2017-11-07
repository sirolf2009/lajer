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
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
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
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class LajerManager implements KeyListener {
  private final Canvas canvas;
  
  private final XYLayout layout;
  
  private final Figure root;
  
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
    HashSet<PortFigure> _hashSet = new HashSet<PortFigure>();
    this.selected = _hashSet;
    HashSet<PortFigure> _hashSet_1 = new HashSet<PortFigure>();
    this.inputPorts = _hashSet_1;
    HashSet<PortFigure> _hashSet_2 = new HashSet<PortFigure>();
    this.outputPorts = _hashSet_2;
    ArrayList<INodeFigure> _arrayList = new ArrayList<INodeFigure>();
    this.nodes = _arrayList;
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
  
  @Pure
  public Canvas getCanvas() {
    return this.canvas;
  }
  
  @Pure
  public XYLayout getLayout() {
    return this.layout;
  }
  
  @Pure
  public Figure getRoot() {
    return this.root;
  }
  
  @Pure
  public LajerEditor getEditor() {
    return this.editor;
  }
  
  @Pure
  public List<INodeFigure> getNodes() {
    return this.nodes;
  }
  
  @Pure
  public Set<PortFigure> getSelected() {
    return this.selected;
  }
  
  @Pure
  public Set<PortFigure> getInputPorts() {
    return this.inputPorts;
  }
  
  @Pure
  public Set<PortFigure> getOutputPorts() {
    return this.outputPorts;
  }
  
  @Pure
  public PortFigure getFocused() {
    return this.focused;
  }
  
  public void setFocused(final PortFigure focused) {
    this.focused = focused;
  }
  
  @Pure
  public boolean isCtrlPressed() {
    return this.ctrlPressed;
  }
  
  public void setCtrlPressed(final boolean ctrlPressed) {
    this.ctrlPressed = ctrlPressed;
  }
  
  @Pure
  public boolean isShiftPressed() {
    return this.shiftPressed;
  }
  
  public void setShiftPressed(final boolean shiftPressed) {
    this.shiftPressed = shiftPressed;
  }
}
