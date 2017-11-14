package com.sirolf2009.lajer.plugin.lajer;

import com.sirolf2009.lajer.core.model.NodeModel;
import com.sirolf2009.lajer.core.model.OperationModel;
import com.sirolf2009.lajer.core.model.PortModel;
import com.sirolf2009.lajer.core.model.SplitterModel;
import com.sirolf2009.lajer.plugin.LajerEditor;
import com.sirolf2009.lajer.plugin.figure.CallbackConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.NodeFigure;
import com.sirolf2009.lajer.plugin.figure.OperationInputFigure;
import com.sirolf2009.lajer.plugin.figure.OperationOutputFigure;
import com.sirolf2009.lajer.plugin.figure.OriginConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.figure.SplitterFigure;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.core.runtime.IPath;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.FigureListener;
import org.eclipse.draw2d.IFigure;
import org.eclipse.draw2d.Label;
import org.eclipse.draw2d.XYLayout;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.jdt.core.IPackageFragmentRoot;
import org.eclipse.jdt.core.JavaCore;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Pair;

@SuppressWarnings("all")
public class LajerManager {
  private final Canvas canvas;
  
  private final XYLayout layout;
  
  private final Figure root;
  
  private final LajerEditor editor;
  
  private final List<INodeFigure> nodes;
  
  private final Set<PortFigure> selected;
  
  private final Set<InputFigure> inputPorts;
  
  private final Set<OutputFigure> outputPorts;
  
  private PortFigure focused;
  
  public LajerManager(final Canvas canvas, final XYLayout layout, final Figure root, final LajerEditor editor) {
    this.canvas = canvas;
    this.layout = layout;
    this.root = root;
    this.editor = editor;
    HashSet<PortFigure> _hashSet = new HashSet<PortFigure>();
    this.selected = _hashSet;
    HashSet<InputFigure> _hashSet_1 = new HashSet<InputFigure>();
    this.inputPorts = _hashSet_1;
    HashSet<OutputFigure> _hashSet_2 = new HashSet<OutputFigure>();
    this.outputPorts = _hashSet_2;
    ArrayList<INodeFigure> _arrayList = new ArrayList<INodeFigure>();
    this.nodes = _arrayList;
  }
  
  public Figure add(final NodeModel node, final int x, final int y) {
    Figure _xifexpression = null;
    if ((node instanceof SplitterModel)) {
      String _name = ((SplitterModel)node).getName();
      Label _label = new Label(_name);
      _xifexpression = new SplitterFigure(this, ((SplitterModel)node), _label);
    } else {
      String _name_1 = node.getName();
      Label _label_1 = new Label(_name_1);
      _xifexpression = new NodeFigure(this, node, _label_1);
    }
    final Figure figure = ((Figure)_xifexpression);
    this.nodes.add(((INodeFigure) figure));
    Rectangle _rectangle = new Rectangle(x, y, (-1), (-1));
    this.layout.setConstraint(figure, _rectangle);
    this.root.add(figure);
    return ((Figure)figure);
  }
  
  public boolean markAsDirty() {
    return this.editor.markAsDirty();
  }
  
  public OperationModel asOperation() {
    try {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/");
      String _name = this.editor.getEditorInput().getFile().getProject().getName();
      _builder.append(_name);
      _builder.append("/");
      IPath _projectRelativePath = this.editor.getEditorInput().getFile().getProjectRelativePath();
      _builder.append(_projectRelativePath);
      final String file = _builder.toString();
      final Function1<IPackageFragmentRoot, Boolean> _function = (IPackageFragmentRoot it) -> {
        return Boolean.valueOf(file.startsWith(it.getPath().makeAbsolute().toString()));
      };
      final IPackageFragmentRoot folder = ((IPackageFragmentRoot[])Conversions.unwrapArray(IterableExtensions.<IPackageFragmentRoot>filter(((Iterable<IPackageFragmentRoot>)Conversions.doWrapArray(JavaCore.create(this.editor.getEditorInput().getFile().getProject()).getAllPackageFragmentRoots())), _function), IPackageFragmentRoot.class))[0];
      int _length = folder.getPath().makeAbsolute().toString().length();
      int _plus = (_length + 1);
      int _length_1 = file.length();
      int _length_2 = ".lajer".length();
      int _minus = (_length_1 - _length_2);
      final String fullyQualifiedName = file.substring(_plus, _minus).replace("/", ".");
      final Function1<INodeFigure, Pair<NodeModel, Pair<Integer, Integer>>> _function_1 = (INodeFigure it) -> {
        Pair<NodeModel, Pair<Integer, Integer>> _xblockexpression = null;
        {
          Object _constraint = this.layout.getConstraint(it);
          final Rectangle constraint = ((Rectangle) _constraint);
          NodeModel _node = it.getNode();
          Pair<Integer, Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(constraint.getTopLeft().x), Integer.valueOf(constraint.getTopLeft().y));
          _xblockexpression = Pair.<NodeModel, Pair<Integer, Integer>>of(_node, _mappedTo);
        }
        return _xblockexpression;
      };
      final Function1<Pair<NodeModel, Pair<Integer, Integer>>, NodeModel> _function_2 = (Pair<NodeModel, Pair<Integer, Integer>> it) -> {
        return it.getKey();
      };
      final Function1<Pair<NodeModel, Pair<Integer, Integer>>, Pair<Integer, Integer>> _function_3 = (Pair<NodeModel, Pair<Integer, Integer>> it) -> {
        return it.getValue();
      };
      final Map<NodeModel, Pair<Integer, Integer>> positions = IterableExtensions.<Pair<NodeModel, Pair<Integer, Integer>>, NodeModel, Pair<Integer, Integer>>toMap(ListExtensions.<INodeFigure, Pair<NodeModel, Pair<Integer, Integer>>>map(this.nodes, _function_1), _function_2, _function_3);
      final Function1<InputFigure, PortModel> _function_4 = (InputFigure it) -> {
        return it.getPort();
      };
      List<PortModel> _list = IterableExtensions.<PortModel>toList(IterableExtensions.<InputFigure, PortModel>map(this.inputPorts, _function_4));
      final Function1<OutputFigure, PortModel> _function_5 = (OutputFigure it) -> {
        return it.getPort();
      };
      List<PortModel> _list_1 = IterableExtensions.<PortModel>toList(IterableExtensions.<OutputFigure, PortModel>map(this.outputPorts, _function_5));
      final Function1<INodeFigure, NodeModel> _function_6 = (INodeFigure it) -> {
        return it.getNode();
      };
      List<NodeModel> _list_2 = IterableExtensions.<NodeModel>toList(ListExtensions.<INodeFigure, NodeModel>map(this.nodes, _function_6));
      return new OperationModel(fullyQualifiedName, _list, _list_1, _list_2, positions);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public OriginConnectionFigure markAsInput(final InputFigure input) {
    final OperationInputFigure operationInputFigure = new OperationInputFigure();
    this.root.add(operationInputFigure);
    final OriginConnectionFigure connection = new OriginConnectionFigure(operationInputFigure, input);
    this.root.add(connection);
    this.inputPorts.add(input);
    final FigureListener _function = (IFigure it) -> {
      Rectangle _rectangle = new Rectangle((input.getBounds().getCenter().x - 80), (input.getBounds().getCenter().y - 10), (-1), (-1));
      this.layout.setConstraint(operationInputFigure, _rectangle);
    };
    input.addFigureListener(_function);
    return connection;
  }
  
  public CallbackConnectionFigure markAsOutput(final OutputFigure output) {
    final OperationOutputFigure operationOutputFigure = new OperationOutputFigure();
    this.root.add(operationOutputFigure);
    final CallbackConnectionFigure connection = new CallbackConnectionFigure(output, operationOutputFigure);
    this.root.add(connection);
    this.outputPorts.add(output);
    final FigureListener _function = (IFigure it) -> {
      Rectangle _rectangle = new Rectangle((output.getBounds().getCenter().x + 80), (output.getBounds().getCenter().y - 10), (-1), (-1));
      this.layout.setConstraint(operationOutputFigure, _rectangle);
    };
    output.addFigureListener(_function);
    return connection;
  }
  
  public void focusOnFirst() {
    this.unfocus();
    int i = 0;
    while (((this.focused == null) && (i < this.nodes.size()))) {
      {
        final INodeFigure it = this.nodes.get(i);
        boolean _isEmpty = it.getInputFigures().isEmpty();
        boolean _not = (!_isEmpty);
        if (_not) {
          this.focus(it.getInputFigures().get(0));
        } else {
          boolean _isEmpty_1 = it.getOutputFigures().isEmpty();
          boolean _not_1 = (!_isEmpty_1);
          if (_not_1) {
            this.focus(it.getOutputFigures().get(0));
          } else {
            i++;
          }
        }
      }
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
  
  public Rectangle getConstraint(final IFigure figure) {
    Object _constraint = this.layout.getConstraint(figure);
    return ((Rectangle) _constraint);
  }
  
  public boolean isInput(final PortFigure port) {
    return (port instanceof InputFigure);
  }
  
  public boolean isOutput(final PortFigure port) {
    return (port instanceof OutputFigure);
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
  
  public Set<InputFigure> getInputPorts() {
    return this.inputPorts;
  }
  
  public Set<OutputFigure> getOutputPorts() {
    return this.outputPorts;
  }
}
