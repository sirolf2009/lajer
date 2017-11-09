package com.sirolf2009.lajer.plugin.lajer.command;

import com.sirolf2009.lajer.plugin.figure.CallbackConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.OperationOutputFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import org.eclipse.draw2d.Figure;
import org.eclipse.draw2d.FigureListener;
import org.eclipse.draw2d.IFigure;
import org.eclipse.draw2d.XYLayout;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.xtext.xbase.lib.Extension;

@SuppressWarnings("all")
public class LajerCommandMarkSelectedAsOutput extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    if (((manager.getFocused() != null) && manager.isOutput(manager.getFocused()))) {
      final OperationOutputFigure operationOutputFigure = new OperationOutputFigure();
      final Rectangle rectOrigin = manager.getConstraint(manager.getFocused().getNode());
      Figure _root = manager.getRoot();
      Rectangle _rectangle = new Rectangle((rectOrigin.getCenter().x + 80), rectOrigin.getCenter().y, (-1), (-1));
      _root.add(operationOutputFigure, _rectangle);
      PortFigure _focused = manager.getFocused();
      final CallbackConnectionFigure connection = new CallbackConnectionFigure(_focused, operationOutputFigure);
      manager.getRoot().add(connection);
      manager.getOutputPorts().add(manager.getFocused());
      final FigureListener _function = (IFigure it) -> {
        final Rectangle rect = manager.getConstraint(manager.getFocused().getNode());
        XYLayout _layout = manager.getLayout();
        Rectangle _rectangle_1 = new Rectangle((rect.getCenter().x + 80), rect.getCenter().y, (-1), (-1));
        _layout.setConstraint(operationOutputFigure, _rectangle_1);
      };
      manager.getFocused().getNode().addFigureListener(_function);
    }
  }
}
