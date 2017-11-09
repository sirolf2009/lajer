package com.sirolf2009.lajer.plugin.lajer.command;

import com.google.common.base.Objects;
import com.sirolf2009.lajer.core.model.ConnectionModel;
import com.sirolf2009.lajer.plugin.figure.ConnectionFigure;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.InputFigure;
import com.sirolf2009.lajer.plugin.figure.OutputFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import java.util.List;
import java.util.Set;
import java.util.function.Consumer;
import org.eclipse.draw2d.IFigure;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;

@SuppressWarnings("all")
public class LajerCommandRemoveSelected extends LajerCommand {
  @Override
  public void accept(@Extension final LajerManager manager) {
    PortFigure _focused = manager.getFocused();
    boolean _tripleNotEquals = (_focused != null);
    if (_tripleNotEquals) {
      final Function1<InputFigure, List<ConnectionModel>> _function = (InputFigure input) -> {
        final Function1<ConnectionModel, ConnectionModel> _function_1 = (ConnectionModel it) -> {
          return it;
        };
        return ListExtensions.<ConnectionModel, ConnectionModel>map(input.getPort().getIncomingConnections(), _function_1);
      };
      final Set<ConnectionModel> incomingConnections = IterableExtensions.<ConnectionModel>toSet(IterableExtensions.<InputFigure, ConnectionModel>flatMap(manager.getFocused().getNode().getInputFigures(), _function));
      final Consumer<ConnectionModel> _function_1 = (ConnectionModel it) -> {
        final Function1<Object, Boolean> _function_2 = (Object it_1) -> {
          return Boolean.valueOf((it_1 instanceof ConnectionFigure));
        };
        final Function1<Object, ConnectionFigure> _function_3 = (Object it_1) -> {
          return ((ConnectionFigure) it_1);
        };
        final Function1<ConnectionFigure, Boolean> _function_4 = (ConnectionFigure it_1) -> {
          return Boolean.valueOf((Objects.equal(it_1.getInput(), it_1.getInput()) && Objects.equal(it_1.getOutput(), it_1.getOutput())));
        };
        manager.getRoot().getChildren().removeAll(IterableExtensions.<ConnectionFigure>toList(IterableExtensions.<ConnectionFigure>filter(IterableExtensions.<Object, ConnectionFigure>map(IterableExtensions.<Object>filter(manager.getRoot().getChildren(), _function_2), _function_3), _function_4)));
        it.getFrom().getOutgoingConnections().remove(it);
        it.getTo().getIncomingConnections().remove(it);
      };
      incomingConnections.forEach(_function_1);
      final Function1<OutputFigure, List<ConnectionModel>> _function_2 = (OutputFigure output) -> {
        final Function1<ConnectionModel, ConnectionModel> _function_3 = (ConnectionModel it) -> {
          return it;
        };
        return ListExtensions.<ConnectionModel, ConnectionModel>map(output.getPort().getOutgoingConnections(), _function_3);
      };
      final Iterable<ConnectionModel> outgoingConnections = IterableExtensions.<OutputFigure, ConnectionModel>flatMap(manager.getFocused().getNode().getOutputFigures(), _function_2);
      final Consumer<ConnectionModel> _function_3 = (ConnectionModel it) -> {
        final Function1<Object, Boolean> _function_4 = (Object it_1) -> {
          return Boolean.valueOf((it_1 instanceof ConnectionFigure));
        };
        final Function1<Object, ConnectionFigure> _function_5 = (Object it_1) -> {
          return ((ConnectionFigure) it_1);
        };
        final Function1<ConnectionFigure, Boolean> _function_6 = (ConnectionFigure it_1) -> {
          return Boolean.valueOf((Objects.equal(it_1.getInput(), it_1.getInput()) && Objects.equal(it_1.getOutput(), it_1.getOutput())));
        };
        manager.getRoot().getChildren().removeAll(IterableExtensions.<ConnectionFigure>toList(IterableExtensions.<ConnectionFigure>filter(IterableExtensions.<Object, ConnectionFigure>map(IterableExtensions.<Object>filter(manager.getRoot().getChildren(), _function_4), _function_5), _function_6)));
        it.getFrom().getOutgoingConnections().remove(it);
        it.getTo().getIncomingConnections().remove(it);
      };
      outgoingConnections.forEach(_function_3);
      manager.getNodes().remove(manager.getFocused().getNode());
      INodeFigure _node = manager.getFocused().getNode();
      manager.getRoot().remove(((IFigure) _node));
      manager.unfocus();
      manager.getRoot().repaint();
      manager.markAsDirty();
    }
  }
}
