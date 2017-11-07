package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.plugin.figure.PortFigure;
import org.eclipse.draw2d.ChopboxAnchor;
import org.eclipse.draw2d.PolygonDecoration;
import org.eclipse.draw2d.PolylineConnection;
import org.eclipse.draw2d.geometry.PointList;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@Data
@SuppressWarnings("all")
public class ConnectionFigure extends PolylineConnection {
  private final PortFigure input;
  
  private final PortFigure output;
  
  public ConnectionFigure(final PortFigure input, final PortFigure output) {
    this.input = input;
    this.output = output;
    ChopboxAnchor _chopboxAnchor = new ChopboxAnchor(output);
    this.setSourceAnchor(_chopboxAnchor);
    ChopboxAnchor _chopboxAnchor_1 = new ChopboxAnchor(input);
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
  
  @Override
  @Pure
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + ((this.input== null) ? 0 : this.input.hashCode());
    result = prime * result + ((this.output== null) ? 0 : this.output.hashCode());
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
    ConnectionFigure other = (ConnectionFigure) obj;
    if (this.input == null) {
      if (other.input != null)
        return false;
    } else if (!this.input.equals(other.input))
      return false;
    if (this.output == null) {
      if (other.output != null)
        return false;
    } else if (!this.output.equals(other.output))
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
  
  @Pure
  public PortFigure getInput() {
    return this.input;
  }
  
  @Pure
  public PortFigure getOutput() {
    return this.output;
  }
}
