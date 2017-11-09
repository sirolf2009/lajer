package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.core.model.NodeModel;
import com.sirolf2009.lajer.core.model.PortModel;
import com.sirolf2009.lajer.plugin.figure.BoxFigure;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.draw2d.BorderLayout;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.Label;
import org.eclipse.draw2d.ToolbarLayout;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class NodeFigure extends Figure implements INodeFigure {
  private final NodeModel node;
  
  private final List<InputFigure> inputFigures;
  
  private final List<OutputFigure> outputFigures;
  
  public NodeFigure(final LajerManager manager, final NodeModel node, final Label name) {
    this.node = node;
    ToolbarLayout _toolbarLayout = new ToolbarLayout(true);
    final Procedure1<ToolbarLayout> _function = (ToolbarLayout it) -> {
      it.setStretchMinorAxis(true);
    };
    ToolbarLayout _doubleArrow = ObjectExtensions.<ToolbarLayout>operator_doubleArrow(_toolbarLayout, _function);
    this.setLayoutManager(_doubleArrow);
    this.setOpaque(true);
    ArrayList<InputFigure> _arrayList = new ArrayList<InputFigure>();
    this.inputFigures = _arrayList;
    Figure _figure = new Figure();
    final Procedure1<Figure> _function_1 = (Figure it) -> {
      ToolbarLayout _toolbarLayout_1 = new ToolbarLayout(false);
      final Procedure1<ToolbarLayout> _function_2 = (ToolbarLayout it_1) -> {
        it_1.setMinorAlignment(ToolbarLayout.ALIGN_CENTER);
      };
      ToolbarLayout _doubleArrow_1 = ObjectExtensions.<ToolbarLayout>operator_doubleArrow(_toolbarLayout_1, _function_2);
      it.setLayoutManager(_doubleArrow_1);
      final Consumer<PortModel> _function_3 = (PortModel port) -> {
        Figure _figure_1 = new Figure();
        final Procedure1<Figure> _function_4 = (Figure it_1) -> {
          ToolbarLayout _toolbarLayout_2 = new ToolbarLayout(true);
          final Procedure1<ToolbarLayout> _function_5 = (ToolbarLayout it_2) -> {
            it_2.setMinorAlignment(ToolbarLayout.ALIGN_CENTER);
          };
          ToolbarLayout _doubleArrow_2 = ObjectExtensions.<ToolbarLayout>operator_doubleArrow(_toolbarLayout_2, _function_5);
          it_1.setLayoutManager(_doubleArrow_2);
          InputFigure _inputFigure = new InputFigure(this, port, manager);
          final Procedure1<InputFigure> _function_6 = (InputFigure it_2) -> {
            this.inputFigures.add(it_2);
          };
          InputFigure _doubleArrow_3 = ObjectExtensions.<InputFigure>operator_doubleArrow(_inputFigure, _function_6);
          it_1.add(_doubleArrow_3);
        };
        Figure _doubleArrow_2 = ObjectExtensions.<Figure>operator_doubleArrow(_figure_1, _function_4);
        it.add(_doubleArrow_2);
      };
      node.getInputPorts().forEach(_function_3);
    };
    Figure _doubleArrow_1 = ObjectExtensions.<Figure>operator_doubleArrow(_figure, _function_1);
    this.add(_doubleArrow_1);
    BoxFigure _boxFigure = new BoxFigure();
    final Procedure1<BoxFigure> _function_2 = (BoxFigure it) -> {
      it.add(name, BorderLayout.CENTER);
    };
    BoxFigure _doubleArrow_2 = ObjectExtensions.<BoxFigure>operator_doubleArrow(_boxFigure, _function_2);
    this.add(_doubleArrow_2);
    ArrayList<OutputFigure> _arrayList_1 = new ArrayList<OutputFigure>();
    this.outputFigures = _arrayList_1;
    Figure _figure_1 = new Figure();
    final Procedure1<Figure> _function_3 = (Figure it) -> {
      ToolbarLayout _toolbarLayout_1 = new ToolbarLayout(false);
      final Procedure1<ToolbarLayout> _function_4 = (ToolbarLayout it_1) -> {
        it_1.setMinorAlignment(ToolbarLayout.ALIGN_CENTER);
      };
      ToolbarLayout _doubleArrow_3 = ObjectExtensions.<ToolbarLayout>operator_doubleArrow(_toolbarLayout_1, _function_4);
      it.setLayoutManager(_doubleArrow_3);
      final Consumer<PortModel> _function_5 = (PortModel port) -> {
        Figure _figure_2 = new Figure();
        final Procedure1<Figure> _function_6 = (Figure it_1) -> {
          ToolbarLayout _toolbarLayout_2 = new ToolbarLayout(true);
          final Procedure1<ToolbarLayout> _function_7 = (ToolbarLayout it_2) -> {
            it_2.setMinorAlignment(ToolbarLayout.ALIGN_CENTER);
          };
          ToolbarLayout _doubleArrow_4 = ObjectExtensions.<ToolbarLayout>operator_doubleArrow(_toolbarLayout_2, _function_7);
          it_1.setLayoutManager(_doubleArrow_4);
          OutputFigure _outputFigure = new OutputFigure(this, port, manager);
          final Procedure1<OutputFigure> _function_8 = (OutputFigure it_2) -> {
            this.outputFigures.add(it_2);
          };
          OutputFigure _doubleArrow_5 = ObjectExtensions.<OutputFigure>operator_doubleArrow(_outputFigure, _function_8);
          it_1.add(_doubleArrow_5);
        };
        Figure _doubleArrow_4 = ObjectExtensions.<Figure>operator_doubleArrow(_figure_2, _function_6);
        it.add(_doubleArrow_4);
      };
      node.getOutputPorts().forEach(_function_5);
    };
    Figure _doubleArrow_3 = ObjectExtensions.<Figure>operator_doubleArrow(_figure_1, _function_3);
    this.add(_doubleArrow_3);
  }
  
  @Override
  public NodeModel getNode() {
    return this.node;
  }
  
  @Override
  public List<InputFigure> getInputFigures() {
    return this.inputFigures;
  }
  
  @Override
  public List<OutputFigure> getOutputFigures() {
    return this.outputFigures;
  }
}
