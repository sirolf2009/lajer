package com.sirolf2009.lajer.plugin.lajer.command;

import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.geometry.Point;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public abstract class LajerCommandMoveSelected extends LajerCommand {
  public static class LajerCommandMoveSelectedUp extends LajerCommandMoveSelected {
    public LajerCommandMoveSelectedUp(final int amount) {
      super(new Point(0, (-amount)));
    }
    
    @Override
    public String name() {
      return "move-selected-up";
    }
  }
  
  public static class LajerCommandMoveSelectedRight extends LajerCommandMoveSelected {
    public LajerCommandMoveSelectedRight(final int amount) {
      super(new Point(amount, 0));
    }
    
    @Override
    public String name() {
      return "move-selected-right";
    }
  }
  
  public static class LajerCommandMoveSelectedDown extends LajerCommandMoveSelected {
    public LajerCommandMoveSelectedDown(final int amount) {
      super(new Point(0, amount));
    }
    
    @Override
    public String name() {
      return "move-selected-down";
    }
  }
  
  public static class LajerCommandMoveSelectedLeft extends LajerCommandMoveSelected {
    public LajerCommandMoveSelectedLeft(final int amount) {
      super(new Point((-amount), 0));
    }
    
    @Override
    public String name() {
      return "move-selected-left";
    }
  }
  
  private final Point translation;
  
  public LajerCommandMoveSelected(final Point translation) {
    this.translation = translation;
  }
  
  @Override
  public void accept(@Extension final LajerManager manager) {
    PortFigure _focused = manager.getFocused();
    boolean _tripleNotEquals = (_focused != null);
    if (_tripleNotEquals) {
      INodeFigure _node = manager.getFocused().getNode();
      Object _constraint = manager.getLayout().getConstraint(((Figure) _node));
      final Rectangle rect = ((Rectangle) _constraint);
      INodeFigure _node_1 = manager.getFocused().getNode();
      manager.getLayout().setConstraint(((Figure) _node_1), rect.translate(this.translation));
      INodeFigure _node_2 = manager.getFocused().getNode();
      manager.getLayout().layout(((Figure) _node_2).getParent());
    }
  }
  
  @Override
  public String author() {
    return "sirolf2009";
  }
}
