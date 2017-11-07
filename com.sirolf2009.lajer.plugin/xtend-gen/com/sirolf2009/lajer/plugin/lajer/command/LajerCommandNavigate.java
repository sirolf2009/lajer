package com.sirolf2009.lajer.plugin.lajer.command;

import com.google.common.base.Objects;
import com.sirolf2009.lajer.plugin.figure.INodeFigure;
import com.sirolf2009.lajer.plugin.figure.PortFigure;
import com.sirolf2009.lajer.plugin.lajer.LajerManager;
import com.sirolf2009.lajer.plugin.lajer.command.LajerCommand;
import java.util.Comparator;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Stream;
import org.eclipse.draw2d.Label;
import org.eclipse.draw2d.geometry.Point;
import org.eclipse.swt.widgets.Display;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Extension;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public abstract class LajerCommandNavigate extends LajerCommand {
  public static class NavigateUp extends LajerCommandNavigate {
    public NavigateUp(final int losRange) {
      super(((Function<Double, Boolean>) (Double it) -> {
        return Boolean.valueOf((((it).doubleValue() > (270 - losRange)) && ((it).doubleValue() < (270 + losRange))));
      }));
    }
    
    @Override
    public String name() {
      return "navigate-up";
    }
    
    @Override
    public String author() {
      return "sirolf2009";
    }
  }
  
  public static class NavigateRight extends LajerCommandNavigate {
    public NavigateRight(final int losRange) {
      super(((Function<Double, Boolean>) (Double it) -> {
        return Boolean.valueOf((((it).doubleValue() > (360 - losRange)) || ((it).doubleValue() < losRange)));
      }));
    }
    
    @Override
    public String name() {
      return "navigate-right";
    }
    
    @Override
    public String author() {
      return "sirolf2009";
    }
  }
  
  public static class NavigateDown extends LajerCommandNavigate {
    public NavigateDown(final int losRange) {
      super(((Function<Double, Boolean>) (Double it) -> {
        return Boolean.valueOf((((it).doubleValue() > (90 - losRange)) && ((it).doubleValue() < (90 + losRange))));
      }));
    }
    
    @Override
    public String name() {
      return "navigate-down";
    }
    
    @Override
    public String author() {
      return "sirolf2009";
    }
  }
  
  public static class NavigateLeft extends LajerCommandNavigate {
    public NavigateLeft(final int losRange) {
      super(((Function<Double, Boolean>) (Double it) -> {
        return Boolean.valueOf((((it).doubleValue() > (180 - losRange)) && ((it).doubleValue() < (180 + losRange))));
      }));
    }
    
    @Override
    public String name() {
      return "navigate-left";
    }
    
    @Override
    public String author() {
      return "sirolf2009";
    }
  }
  
  private final Function<Double, Boolean> withinAngle;
  
  public LajerCommandNavigate(final Function<Double, Boolean> withinAngle) {
    this.withinAngle = withinAngle;
  }
  
  @Override
  public void accept(@Extension final LajerManager manager) {
    PortFigure _focused = manager.getFocused();
    boolean _tripleEquals = (_focused == null);
    if (_tripleEquals) {
      manager.focusOnFirst();
    } else {
      final Point me = manager.getFocused().getBounds().getCenter();
      final Function<INodeFigure, Stream<PortFigure>> _function = (INodeFigure it) -> {
        return Stream.<PortFigure>concat(it.getInputFigures().stream(), it.getOutputFigures().stream());
      };
      final Predicate<PortFigure> _function_1 = (PortFigure it) -> {
        PortFigure _focused_1 = manager.getFocused();
        return (!Objects.equal(it, _focused_1));
      };
      final Predicate<PortFigure> _function_2 = (PortFigure it) -> {
        return (this.withinAngle.apply(Double.valueOf(LajerCommandNavigate.getAngle(me, it.getBounds().getCenter())))).booleanValue();
      };
      final Comparator<PortFigure> _function_3 = (PortFigure a, PortFigure b) -> {
        return Double.valueOf(Math.abs(a.getBounds().getCenter().getDistance(me))).compareTo(Double.valueOf(b.getBounds().getCenter().getDistance(me)));
      };
      final Consumer<PortFigure> _function_4 = (PortFigure it) -> {
        manager.focus(it);
      };
      manager.getNodes().parallelStream().<PortFigure>flatMap(_function).filter(_function_1).filter(_function_2).min(_function_3).ifPresent(_function_4);
    }
  }
  
  protected void showRangeLabels(@Extension final LajerManager manager) {
    final Point me = manager.getFocused().getBounds().getCenter();
    final Function<INodeFigure, Stream<PortFigure>> _function = (INodeFigure it) -> {
      return Stream.<PortFigure>concat(it.getInputFigures().stream(), it.getOutputFigures().stream());
    };
    final Predicate<PortFigure> _function_1 = (PortFigure it) -> {
      PortFigure _focused = manager.getFocused();
      return (it != _focused);
    };
    final Consumer<PortFigure> _function_2 = (PortFigure it) -> {
      final double angle = LajerCommandNavigate.getAngle(me, it.getBounds().getCenter());
      String _plus = (Double.valueOf(angle) + "");
      Label _label = new Label(_plus);
      final Procedure1<Label> _function_3 = (Label it_1) -> {
        it_1.setLocation(it_1.getBounds().getCenter());
      };
      final Label label = ObjectExtensions.<Label>operator_doubleArrow(_label, _function_3);
      it.add(label);
      final Runnable _function_4 = () -> {
        try {
          Thread.sleep(2000);
          final Runnable _function_5 = () -> {
            it.remove(label);
          };
          Display.getDefault().asyncExec(_function_5);
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      };
      new Thread(_function_4).start();
    };
    manager.getNodes().parallelStream().<PortFigure>flatMap(_function).filter(_function_1).sequential().forEach(_function_2);
  }
  
  public static double getAngle(final Point a, final Point b) {
    final double angle = Math.toDegrees(Math.atan2((b.y - a.y), (b.x - a.x)));
    double _xifexpression = (double) 0;
    if ((angle >= 0)) {
      _xifexpression = angle;
    } else {
      _xifexpression = (angle + 360);
    }
    return _xifexpression;
  }
}
