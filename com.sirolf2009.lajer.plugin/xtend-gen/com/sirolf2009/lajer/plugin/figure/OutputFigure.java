package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import org.eclipse.draw2d.AbstractBorder;
import org.eclipse.draw2d.Graphics;
import org.eclipse.draw2d.IFigure;
import org.eclipse.draw2d.geometry.Insets;
import org.eclipse.draw2d.geometry.PointList;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@SuppressWarnings("all")
public class OutputFigure extends PortFigure {
  @Data
  public static class OutputFigureBorder extends PortFigure.PortFigureBorder {
    @Override
    public PointList getShape(final IFigure figure, final Graphics graphics, final Insets insets) {
      PointList _pointList = new PointList();
      final Procedure1<PointList> _function = (PointList list) -> {
        Rectangle _paintRectangle = AbstractBorder.getPaintRectangle(figure, insets);
        final Procedure1<Rectangle> _function_1 = (Rectangle it) -> {
          list.addPoint(it.getTopLeft().getTranslated(1, 3));
          list.addPoint(it.getTopRight().getTranslated((-1), 1));
          list.addPoint(it.getBottomRight().getTranslated((-1), (-1)));
          list.addPoint(it.getBottomLeft().getTranslated(1, (-3)));
        };
        ObjectExtensions.<Rectangle>operator_doubleArrow(_paintRectangle, _function_1);
      };
      return ObjectExtensions.<PointList>operator_doubleArrow(_pointList, _function);
    }
    
    public OutputFigureBorder(final PortFigure port) {
      super(port);
    }
    
    @Override
    @Pure
    public int hashCode() {
      int result = super.hashCode();
      return result;
    }
    
    @Override
    @Pure
    public boolean equals(final Object obj) {
      if (this == obj)
        return true;
      if (obj == null)
        return false;
      if (getClass() != obj.getClass())
        return false;
      if (!super.equals(obj))
        return false;
      return true;
    }
    
    @Override
    @Pure
    public String toString() {
      String result = new ToStringBuilder(this)
      	.addAllFields()
      	.toString();
      return result;
    }
  }
  
  public OutputFigure(final INodeFigure node, final Port port, final LajerManager manager) {
    super(node, port, manager);
    OutputFigure.OutputFigureBorder _outputFigureBorder = new OutputFigure.OutputFigureBorder(this);
    this.setBorder(_outputFigureBorder);
  }
}
