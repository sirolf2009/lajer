package com.sirolf2009.lajer.plugin.figure;

import org.eclipse.draw2d.Ellipse;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.StackLayout;
import org.eclipse.draw2d.geometry.Dimension;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.swt.graphics.Color;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class OperationOutputFigure extends Figure {
  private static class Circle extends Ellipse {
    private final int size;
    
    public Circle(final int size) {
      this.size = size;
    }
    
    @Override
    public void setBounds(final Rectangle rect) {
      Rectangle _rectangle = new Rectangle((rect.getCenter().x - (this.size / 2)), (rect.getCenter().y - (this.size / 2)), this.size, this.size);
      super.setBounds(_rectangle);
    }
  }
  
  public OperationOutputFigure() {
    StackLayout _stackLayout = new StackLayout();
    this.setLayoutManager(_stackLayout);
    Ellipse _ellipse = new Ellipse();
    final Procedure1<Ellipse> _function = (Ellipse it) -> {
      Dimension _dimension = new Dimension(20, 20);
      it.setSize(_dimension);
      Color _color = new Color(null, 0, 0, 0);
      it.setBackgroundColor(_color);
    };
    Ellipse _doubleArrow = ObjectExtensions.<Ellipse>operator_doubleArrow(_ellipse, _function);
    this.add(_doubleArrow);
    OperationOutputFigure.Circle _circle = new OperationOutputFigure.Circle(12);
    final Procedure1<OperationOutputFigure.Circle> _function_1 = (OperationOutputFigure.Circle it) -> {
      Color _color = new Color(null, 255, 255, 255);
      it.setBackgroundColor(_color);
    };
    OperationOutputFigure.Circle _doubleArrow_1 = ObjectExtensions.<OperationOutputFigure.Circle>operator_doubleArrow(_circle, _function_1);
    this.add(_doubleArrow_1);
    OperationOutputFigure.Circle _circle_1 = new OperationOutputFigure.Circle(8);
    final Procedure1<OperationOutputFigure.Circle> _function_2 = (OperationOutputFigure.Circle it) -> {
      Color _color = new Color(null, 0, 0, 0);
      it.setBackgroundColor(_color);
    };
    OperationOutputFigure.Circle _doubleArrow_2 = ObjectExtensions.<OperationOutputFigure.Circle>operator_doubleArrow(_circle_1, _function_2);
    this.add(_doubleArrow_2);
  }
}
