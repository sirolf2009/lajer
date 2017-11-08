package com.sirolf2009.lajer.plugin.lajer.command;

import com.google.common.base.Objects;
import com.sirolf2009.lajer.core.model.ConnectionModel;
import com.sirolf2009.lajer.core.model.PortModel;
import com.sirolf2009.lajer.plugin.figure.ConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public class LajerCommandDisconnectSelected extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    int _size = manager.getSelected().size();
    boolean _greaterThan = (_size > 0);
    if (_greaterThan) {
      final Function1<PortFigure, Boolean> _function = (PortFigure it) -> {
        return Boolean.valueOf(manager.isInput(it));
      };
      final List<PortFigure> inputs = IterableExtensions.<PortFigure>toList(IterableExtensions.<PortFigure>filter(manager.getSelected(), _function));
      final Function1<PortFigure, Boolean> _function_1 = (PortFigure it) -> {
        return Boolean.valueOf(manager.isOutput(it));
      };
      final List<PortFigure> outputs = IterableExtensions.<PortFigure>toList(IterableExtensions.<PortFigure>filter(manager.getSelected(), _function_1));
      final Consumer<PortFigure> _function_2 = (PortFigure input) -> {
        final Consumer<PortFigure> _function_3 = (PortFigure output) -> {
          final Function1<ConnectionModel, Boolean> _function_4 = (ConnectionModel it) -> {
            PortModel _from = it.getFrom();
            PortModel _port = output.getPort();
            return Boolean.valueOf(Objects.equal(_from, _port));
          };
          final Function1<ConnectionModel, Boolean> _function_5 = (ConnectionModel it) -> {
            return Boolean.valueOf(true);
          };
          final ConnectionModel connection = IterableExtensions.<ConnectionModel>findFirst(IterableExtensions.<ConnectionModel>filter(input.getPort().getIncomingConnections(), _function_4), _function_5);
          if ((connection != null)) {
            final Function1<Object, Boolean> _function_6 = (Object it) -> {
              return Boolean.valueOf((it instanceof ConnectionFigure));
            };
            final Function1<Object, ConnectionFigure> _function_7 = (Object it) -> {
              return ((ConnectionFigure) it);
            };
            final Function1<ConnectionFigure, Boolean> _function_8 = (ConnectionFigure it) -> {
              return Boolean.valueOf((Objects.equal(it.getInput(), input) && Objects.equal(it.getOutput(), output)));
            };
            manager.getRoot().getChildren().removeAll(IterableExtensions.<ConnectionFigure>toList(IterableExtensions.<ConnectionFigure>filter(IterableExtensions.<Object, ConnectionFigure>map(IterableExtensions.<Object>filter(manager.getRoot().getChildren(), _function_6), _function_7), _function_8)));
            connection.getFrom().getOutgoingConnections().remove(connection);
            connection.getTo().getIncomingConnections().remove(connection);
          }
        };
        outputs.forEach(_function_3);
      };
      inputs.forEach(_function_2);
      final Consumer<PortFigure> _function_3 = (PortFigure it) -> {
        it.setSelected(false);
        it.repaint();
      };
      manager.getSelected().forEach(_function_3);
      manager.getSelected().clear();
      manager.markAsDirty();
    }
  }
  
  @Override
  public String name() {
    return "disconnect-selected";
  }
  
  @Override
  public String author() {
    return "sirolf2009";
  }
}
