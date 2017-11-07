package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.core.splitter.DummyPort;
import com.sirolf2009.lajer.core.splitter.Splitter;
import com.sirolf2009.lajer.plugin.figure.BoxFigure;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import java.util.Collections;
import java.util.List;
import org.eclipse.draw2d.BorderLayout;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.Label;
import org.eclipse.draw2d.ToolbarLayout;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class SplitterFigure extends Figure implements INodeFigure {
  private final Splitter splitter;
  
  private final InputFigure inputFigure;
  
  private final OutputFigure trueFigure;
  
  private final OutputFigure falseFigure;
  
  public SplitterFigure(final LajerManager manager, final Splitter splitter, final Label name) {
    this.splitter = splitter;
    ToolbarLayout _toolbarLayout = new ToolbarLayout();
    final Procedure1<ToolbarLayout> _function = (ToolbarLayout it) -> {
      it.setMinorAlignment(ToolbarLayout.ALIGN_TOPLEFT);
      it.setHorizontal(true);
    };
    ToolbarLayout _doubleArrow = ObjectExtensions.<ToolbarLayout>operator_doubleArrow(_toolbarLayout, _function);
    this.setLayoutManager(_doubleArrow);
    this.setOpaque(true);
    Port _get = splitter.getInputPorts().get(0);
    InputFigure _inputFigure = new InputFigure(this, _get, manager);
    this.inputFigure = _inputFigure;
    this.add(this.inputFigure);
    BoxFigure _boxFigure = new BoxFigure();
    final Procedure1<BoxFigure> _function_1 = (BoxFigure it) -> {
      it.add(name, BorderLayout.CENTER);
    };
    BoxFigure _doubleArrow_1 = ObjectExtensions.<BoxFigure>operator_doubleArrow(_boxFigure, _function_1);
    this.add(_doubleArrow_1);
    DummyPort _truePort = splitter.getTruePort();
    OutputFigure _outputFigure = new OutputFigure(this, _truePort, manager);
    this.trueFigure = _outputFigure;
    DummyPort _falsePort = splitter.getFalsePort();
    OutputFigure _outputFigure_1 = new OutputFigure(this, _falsePort, manager);
    this.falseFigure = _outputFigure_1;
    Figure _figure = new Figure();
    final Procedure1<Figure> _function_2 = (Figure it) -> {
      ToolbarLayout _toolbarLayout_1 = new ToolbarLayout();
      it.setLayoutManager(_toolbarLayout_1);
      it.add(this.trueFigure);
      it.add(this.falseFigure);
    };
    Figure _doubleArrow_2 = ObjectExtensions.<Figure>operator_doubleArrow(_figure, _function_2);
    this.add(_doubleArrow_2);
  }
  
  @Override
  public Node getNode() {
    return this.splitter;
  }
  
  @Override
  public List<InputFigure> getInputFigures() {
    return Collections.<InputFigure>unmodifiableList(CollectionLiterals.<InputFigure>newArrayList(this.inputFigure));
  }
  
  @Override
  public List<OutputFigure> getOutputFigures() {
    return Collections.<OutputFigure>unmodifiableList(CollectionLiterals.<OutputFigure>newArrayList(this.trueFigure, this.falseFigure));
  }
  
  public Splitter getSplitter() {
    return this.splitter;
  }
  
  public InputFigure getInputFigure() {
    return this.inputFigure;
  }
  
  public OutputFigure getTrueFigure() {
    return this.trueFigure;
  }
  
  public OutputFigure getFalseFigure() {
    return this.falseFigure;
  }
}
