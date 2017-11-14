package com.sirolf2009.lajer.plugin.lajer.command;

import com.google.common.base.Objects;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.OperationInputFigure;
import com.sirolf2009.lajer.plugin.figure.OriginConnectionFigure;
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
public class LajerCommandMarkSelectedAsInput extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    if (((manager.getFocused() != null) && manager.isInput(manager.getFocused()))) {
      boolean _contains = manager.getInputPorts().contains(manager.getFocused());
      if (_contains) {
        manager.getInputPorts().remove(manager.getFocused());
        final Function1<Object, Boolean> _function = (Object it) -> {
          return Boolean.valueOf((it instanceof OriginConnectionFigure));
        };
        final Function1<Object, OriginConnectionFigure> _function_1 = (Object it) -> {
          return ((OriginConnectionFigure) it);
        };
        final Function1<OriginConnectionFigure, Boolean> _function_2 = (OriginConnectionFigure it) -> {
          PortFigure _to = it.getTo();
          PortFigure _focused = manager.getFocused();
          return Boolean.valueOf(Objects.equal(_to, _focused));
        };
        final Set<OriginConnectionFigure> toBeRemoved = IterableExtensions.<OriginConnectionFigure>toSet(IterableExtensions.<OriginConnectionFigure>filter(IterableExtensions.<Object, OriginConnectionFigure>map(IterableExtensions.<Object>filter(manager.getRoot().getChildren(), _function), _function_1), _function_2));
        final Consumer<OriginConnectionFigure> _function_3 = (OriginConnectionFigure it) -> {
          manager.getRoot().remove(it);
          manager.getRoot().remove(it.getFrom());
        };
        toBeRemoved.forEach(_function_3);
      } else {
        PortFigure _focused = manager.getFocused();
        final OriginConnectionFigure connection = manager.markAsInput(((InputFigure) _focused));
        XYLayout _layout = manager.getLayout();
        OperationInputFigure _from = connection.getFrom();
        Rectangle _rectangle = new Rectangle((manager.getFocused().getBounds().getCenter().x - 80), (manager.getFocused().getBounds().getCenter().y - 10), (-1), (-1));
        _layout.setConstraint(_from, _rectangle);
      }
    }
  }
}
