package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.core.model.PortModel;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import org.eclipse.draw2d.AbstractBorder;
import org.eclipse.draw2d.Graphics;
import org.eclipse.draw2d.IFigure;
import org.eclipse.draw2d.geometry.Insets;
import org.eclipse.draw2d.geometry.PointList;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class InputFigure extends PortFigure {
  public static class InputFigureBorder extends PortFigure.PortFigureBorder {
    public InputFigureBorder(final PortFigure port) {
      super(port);
    }
    
    @Override
    public PointList getShape(final IFigure figure, final Graphics graphics, final Insets insets) {
      PointList _pointList = new PointList();
      final Procedure1<PointList> _function = (PointList list) -> {
        Rectangle _paintRectangle = AbstractBorder.getPaintRectangle(figure, insets);
        final Procedure1<Rectangle> _function_1 = (Rectangle it) -> {
          list.addPoint(it.getTopLeft().getTranslated(1, 1));
          list.addPoint(it.getTopRight().getTranslated((-1), 3));
          list.addPoint(it.getBottomRight().getTranslated((-1), (-3)));
          list.addPoint(it.getBottomLeft().getTranslated(1, (-1)));
        };
        ObjectExtensions.<Rectangle>operator_doubleArrow(_paintRectangle, _function_1);
      };
      return ObjectExtensions.<PointList>operator_doubleArrow(_pointList, _function);
    }
  }
  
  public InputFigure(final INodeFigure node, final PortModel port, final LajerManager manager) {
    super(node, port, manager);
    InputFigure.InputFigureBorder _inputFigureBorder = new InputFigure.InputFigureBorder(this);
    this.setBorder(_inputFigureBorder);
  }
}
