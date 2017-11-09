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
  }
  
  public static class LajerCommandMoveSelectedRight extends LajerCommandMoveSelected {
    public LajerCommandMoveSelectedRight(final int amount) {
      super(new Point(amount, 0));
    }
  }
  
  public static class LajerCommandMoveSelectedDown extends LajerCommandMoveSelected {
    public LajerCommandMoveSelectedDown(final int amount) {
      super(new Point(0, amount));
    }
  }
  
  public static class LajerCommandMoveSelectedLeft extends LajerCommandMoveSelected {
    public LajerCommandMoveSelectedLeft(final int amount) {
      super(new Point((-amount), 0));
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
      Object _constraint = manager.getLayout().getConstraint(manager.getFocused().getNode());
      final Rectangle rect = ((Rectangle) _constraint);
      final Rectangle newPos = rect.translate(this.translation);
      INodeFigure _node = manager.getFocused().getNode();
      manager.getLayout().setConstraint(((Figure) _node), newPos);
      INodeFigure _node_1 = manager.getFocused().getNode();
      manager.getLayout().layout(((Figure) _node_1).getParent());
      manager.markAsDirty();
    }
  }
}
