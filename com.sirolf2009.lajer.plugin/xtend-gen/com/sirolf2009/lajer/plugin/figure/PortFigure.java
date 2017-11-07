package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.core.Port;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import org.eclipse.draw2d.AbstractBorder;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.FlowLayout;
import org.eclipse.draw2d.Graphics;
import org.eclipse.draw2d.IFigure;
import org.eclipse.draw2d.MouseEvent;
import org.eclipse.draw2d.MouseListener;
import org.eclipse.draw2d.MouseMotionListener;
import org.eclipse.draw2d.geometry.Insets;
import org.eclipse.draw2d.geometry.PointList;
import org.eclipse.swt.graphics.Color;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtend.lib.annotations.Data;
import org.eclipse.xtext.xbase.lib.Pure;
import org.eclipse.xtext.xbase.lib.util.ToStringBuilder;

@SuppressWarnings("all")
public class PortFigure extends Figure {
  @Data
  public static abstract class PortFigureBorder extends AbstractBorder {
    private final PortFigure port;
    
    @Override
    public Insets getInsets(final IFigure figure) {
      return new Insets(6);
    }
    
    @Override
    public void paint(final IFigure figure, final Graphics graphics, final Insets insets) {
      final PointList shape = this.getShape(figure, graphics, insets);
      if ((this.port.focused && this.port.selected)) {
        Color _color = new Color(null, 82, 132, 229);
        graphics.setBackgroundColor(_color);
        graphics.fillPolygon(shape);
      } else {
        if (this.port.selected) {
          Color _color_1 = new Color(null, 52, 32, 199);
          graphics.setBackgroundColor(_color_1);
          graphics.fillPolygon(shape);
        } else {
          if (this.port.focused) {
            Color _color_2 = new Color(null, 20, 20, 20);
            graphics.setBackgroundColor(_color_2);
            graphics.fillPolygon(shape);
          }
        }
      }
      graphics.drawPolygon(shape);
    }
    
    public abstract PointList getShape(final IFigure figure, final Graphics graphics, final Insets insets);
    
    public PortFigureBorder(final PortFigure port) {
      super();
      this.port = port;
    }
    
    @Override
    @Pure
    public int hashCode() {
      final int prime = 31;
      int result = 1;
      result = prime * result + ((this.port== null) ? 0 : this.port.hashCode());
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
      PortFigure.PortFigureBorder other = (PortFigure.PortFigureBorder) obj;
      if (this.port == null) {
        if (other.port != null)
          return false;
      } else if (!this.port.equals(other.port))
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
    public PortFigure getPort() {
      return this.port;
    }
  }
  
  private final static Color classColor = new Color(null, 206, 206, 225);
  
  private final LajerManager manager;
  
  @Accessors
  private final INodeFigure node;
  
  @Accessors
  private final Port port;
  
  @Accessors
  private boolean focused = false;
  
  @Accessors
  private boolean selected = false;
  
  public PortFigure(final INodeFigure node, final Port port, final LajerManager manager) {
    this.node = node;
    this.port = port;
    this.manager = manager;
    FlowLayout _flowLayout = new FlowLayout();
    this.setLayoutManager(_flowLayout);
    this.setBackgroundColor(PortFigure.classColor);
    this.addMouseListener(new MouseListener() {
      @Override
      public void mouseDoubleClicked(final MouseEvent me) {
      }
      
      @Override
      public void mousePressed(final MouseEvent me) {
        PortFigure.this.selected = (!PortFigure.this.selected);
        PortFigure.this.repaint();
      }
      
      @Override
      public void mouseReleased(final MouseEvent me) {
      }
    });
    this.addMouseMotionListener(new MouseMotionListener() {
      @Override
      public void mouseDragged(final MouseEvent me) {
      }
      
      @Override
      public void mouseEntered(final MouseEvent me) {
        manager.focus(PortFigure.this);
      }
      
      @Override
      public void mouseExited(final MouseEvent me) {
        manager.unfocus();
      }
      
      @Override
      public void mouseHover(final MouseEvent me) {
      }
      
      @Override
      public void mouseMoved(final MouseEvent me) {
      }
    });
  }
  
  @Pure
  public INodeFigure getNode() {
    return this.node;
  }
  
  @Pure
  public Port getPort() {
    return this.port;
  }
  
  @Pure
  public boolean isFocused() {
    return this.focused;
  }
  
  public void setFocused(final boolean focused) {
    this.focused = focused;
  }
  
  @Pure
  public boolean isSelected() {
    return this.selected;
  }
  
  public void setSelected(final boolean selected) {
    this.selected = selected;
  }
}
