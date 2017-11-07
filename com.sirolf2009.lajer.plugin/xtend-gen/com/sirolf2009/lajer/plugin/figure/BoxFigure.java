package com.sirolf2009.lajer.plugin.figure;

import org.eclipse.draw2d.AbstractBorder;
import org.eclipse.draw2d.BorderLayout;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.Graphics;
import org.eclipse.draw2d.IFigure;
import org.eclipse.draw2d.geometry.Insets;
import org.eclipse.draw2d.geometry.PointList;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.swt.graphics.Color;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class BoxFigure extends Figure {
  public static class CompartmentFigureBorder extends AbstractBorder {
    @Override
    public Insets getInsets(final IFigure figure) {
      return new Insets(6);
    }
    
    @Override
    public void paint(final IFigure figure, final Graphics graphics, final Insets insets) {
      Rectangle _paintRectangle = AbstractBorder.getPaintRectangle(figure, insets);
      final Procedure1<Rectangle> _function = (Rectangle it) -> {
        PointList _pointList = new PointList();
        final Procedure1<PointList> _function_1 = (PointList list) -> {
          list.addPoint(it.getTopLeft().getTranslated(1, 1));
          list.addPoint(it.getTopRight().getTranslated((-1), 1));
          list.addPoint(it.getBottomRight().getTranslated((-1), (-1)));
          list.addPoint(it.getBottomLeft().getTranslated(1, (-1)));
        };
        PointList _doubleArrow = ObjectExtensions.<PointList>operator_doubleArrow(_pointList, _function_1);
        graphics.drawPolygon(_doubleArrow);
      };
      ObjectExtensions.<Rectangle>operator_doubleArrow(_paintRectangle, _function);
    }
  }
  
  private final static Color classColor = new Color(null, 206, 206, 225);
  
  public BoxFigure() {
    BorderLayout _borderLayout = new BorderLayout();
    this.setLayoutManager(_borderLayout);
    this.setBackgroundColor(BoxFigure.classColor);
    BoxFigure.CompartmentFigureBorder _compartmentFigureBorder = new BoxFigure.CompartmentFigureBorder();
    this.setBorder(_compartmentFigureBorder);
  }
}
