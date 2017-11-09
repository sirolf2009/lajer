package com.sirolf2009.lajer.plugin.figure;

import org.eclipse.draw2d.Ellipse;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.StackLayout;
import org.eclipse.draw2d.geometry.Dimension;
import org.eclipse.draw2d.geometry.Insets;
import org.eclipse.swt.graphics.Color;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class OperationInputFigure extends Figure {
  public OperationInputFigure() {
    StackLayout _stackLayout = new StackLayout();
    this.setLayoutManager(_stackLayout);
    Ellipse _ellipse = new Ellipse();
    final Procedure1<Ellipse> _function = (Ellipse it) -> {
      Color _color = new Color(null, 0, 0, 0);
      it.setBackgroundColor(_color);
      Dimension _dimension = new Dimension(20, 20);
      it.setSize(_dimension);
    };
    Ellipse _doubleArrow = ObjectExtensions.<Ellipse>operator_doubleArrow(_ellipse, _function);
    this.add(_doubleArrow);
  }
  
  @Override
  public Insets getInsets() {
    return new Insets(6);
  }
}
