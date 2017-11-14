package com.sirolf2009.lajer.plugin.lajer.command;

import com.google.common.base.Objects;
import com.sirolf2009.lajer.plugin.figure.CallbackConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.OperationOutputFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import java.util.Set;
import java.util.function.Consumer;
import org.eclipse.draw2d.XYLayout;
import org.eclipse.draw2d.geometry.Rectangle;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public class LajerCommandMarkSelectedAsOutput extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    if (((manager.getFocused() != null) && manager.isOutput(manager.getFocused()))) {
      boolean _contains = manager.getOutputPorts().contains(manager.getFocused());
      if (_contains) {
        manager.getOutputPorts().remove(manager.getFocused());
        final Function1<Object, Boolean> _function = (Object it) -> {
          return Boolean.valueOf((it instanceof CallbackConnectionFigure));
        };
        final Function1<Object, CallbackConnectionFigure> _function_1 = (Object it) -> {
          return ((CallbackConnectionFigure) it);
        };
        final Function1<CallbackConnectionFigure, Boolean> _function_2 = (CallbackConnectionFigure it) -> {
          PortFigure _from = it.getFrom();
          PortFigure _focused = manager.getFocused();
          return Boolean.valueOf(Objects.equal(_from, _focused));
        };
        final Set<CallbackConnectionFigure> toBeRemoved = IterableExtensions.<CallbackConnectionFigure>toSet(IterableExtensions.<CallbackConnectionFigure>filter(IterableExtensions.<Object, CallbackConnectionFigure>map(IterableExtensions.<Object>filter(manager.getRoot().getChildren(), _function), _function_1), _function_2));
        final Consumer<CallbackConnectionFigure> _function_3 = (CallbackConnectionFigure it) -> {
          manager.getRoot().remove(it);
          manager.getRoot().remove(it.getTo());
        };
        toBeRemoved.forEach(_function_3);
      } else {
        PortFigure _focused = manager.getFocused();
        final CallbackConnectionFigure connection = manager.markAsOutput(((OutputFigure) _focused));
        XYLayout _layout = manager.getLayout();
        OperationOutputFigure _to = connection.getTo();
        Rectangle _rectangle = new Rectangle((manager.getFocused().getBounds().getCenter().x + 80), (manager.getFocused().getBounds().getCenter().y - 10), (-1), (-1));
        _layout.setConstraint(_to, _rectangle);
      }
    }
  }
}
