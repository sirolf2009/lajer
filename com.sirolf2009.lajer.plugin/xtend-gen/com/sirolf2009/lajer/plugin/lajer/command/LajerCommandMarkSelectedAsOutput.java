package com.sirolf2009.lajer.plugin.lajer.command;

import com.sirolf2009.lajer.plugin.figure.CallbackConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.OperationOutputFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import org.eclipse.draw2d.XYLayout;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class LajerCommandMarkSelectedAsOutput extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    if (((manager.getFocused() != null) && manager.isOutput(manager.getFocused()))) {
      boolean _contains = manager.getOutputPorts().contains(manager.getFocused());
      if (_contains) {
        PortFigure _focused = manager.getFocused();
        manager.unmarkAsOutput(((OutputFigure) _focused));
      } else {
        PortFigure _focused_1 = manager.getFocused();
        final CallbackConnectionFigure connection = manager.markAsOutput(((OutputFigure) _focused_1));
        XYLayout _layout = manager.getLayout();
        OperationOutputFigure _to = connection.getTo();
        Rectangle _rectangle = new Rectangle((manager.getFocused().getBounds().getCenter().x + 80), (manager.getFocused().getBounds().getCenter().y - 10), (-1), (-1));
        _layout.setConstraint(_to, _rectangle);
      }
    }
  }
}
