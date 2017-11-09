package com.sirolf2009.lajer.plugin.lajer.command;

import com.sirolf2009.lajer.core.model.ConnectionModel;
import com.sirolf2009.lajer.plugin.figure.ConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.draw2d.Figure;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public class LajerCommandConnectSelected extends LajerCommand {
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
          ConnectionModel.connectTo(output.getPort(), input.getPort());
          Figure _root = manager.getRoot();
          ConnectionFigure _connectionFigure = new ConnectionFigure(input, output);
          _root.add(_connectionFigure);
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
}
