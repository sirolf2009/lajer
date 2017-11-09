package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.plugin.figure.OperationInputFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import org.eclipse.draw2d.ChopboxAnchor;
import org.eclipse.draw2d.PolygonDecoration;
import org.eclipse.draw2d.PolylineConnection;
import org.eclipse.draw2d.geometry.PointList;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class OriginConnectionFigure extends PolylineConnection {
  private final OperationInputFigure from;
  
  private final PortFigure to;
  
  public OriginConnectionFigure(final OperationInputFigure from, final PortFigure to) {
    this.from = from;
    this.to = to;
    ChopboxAnchor _chopboxAnchor = new ChopboxAnchor(from);
    this.setSourceAnchor(_chopboxAnchor);
    ChopboxAnchor _chopboxAnchor_1 = new ChopboxAnchor(to);
    this.setTargetAnchor(_chopboxAnchor_1);
    PolygonDecoration _polygonDecoration = new PolygonDecoration();
    final Procedure1<PolygonDecoration> _function = (PolygonDecoration it) -> {
      PointList _pointList = new PointList();
      final Procedure1<PointList> _function_1 = (PointList it_1) -> {
        it_1.addPoint((-2), (-2));
        it_1.addPoint((-2), 2);
        it_1.addPoint(0, 0);
      };
      PointList _doubleArrow = ObjectExtensions.<PointList>operator_doubleArrow(_pointList, _function_1);
      it.setTemplate(_doubleArrow);
    };
    PolygonDecoration _doubleArrow = ObjectExtensions.<PolygonDecoration>operator_doubleArrow(_polygonDecoration, _function);
    this.setTargetDecoration(_doubleArrow);
  }
  
  public OperationInputFigure getFrom() {
    return this.from;
  }
  
  public PortFigure getTo() {
    return this.to;
  }
}
