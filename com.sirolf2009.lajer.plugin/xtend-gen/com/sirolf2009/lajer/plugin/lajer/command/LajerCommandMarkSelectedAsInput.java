package com.sirolf2009.lajer.plugin.lajer.command;

import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.OperationInputFigure;
import com.sirolf2009.lajer.plugin.figure.OriginConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import org.eclipse.draw2d.XYLayout;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class LajerCommandMarkSelectedAsInput extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    if (((manager.getFocused() != null) && manager.isInput(manager.getFocused()))) {
      boolean _contains = manager.getInputPorts().contains(manager.getFocused());
      if (_contains) {
        PortFigure _focused = manager.getFocused();
        manager.unmarkAsInput(((InputFigure) _focused));
      } else {
        PortFigure _focused_1 = manager.getFocused();
        final OriginConnectionFigure connection = manager.markAsInput(((InputFigure) _focused_1));
        XYLayout _layout = manager.getLayout();
        OperationInputFigure _from = connection.getFrom();
        Rectangle _rectangle = new Rectangle((manager.getFocused().getBounds().getCenter().x - 80), (manager.getFocused().getBounds().getCenter().y - 10), (-1), (-1));
        _layout.setConstraint(_from, _rectangle);
      }
    }
  }
}
