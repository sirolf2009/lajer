package com.sirolf2009.lajer.plugin.figure;

import com.sirolf2009.lajer.core.Node;
import com.sirolf2009.lajer.core.Port;
import java.util.Optional;
import java.util.function.Consumer;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.events.MouseListener;
import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.events.PaintListener;
import org.eclipse.swt.graphics.Image;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.layout.FillLayout;
import org.eclipse.swt.layout.RowData;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Canvas;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class RenderedNode extends Composite implements Listener {
  private static class Square extends Canvas {
    private final int width;
    
    private final int height;
    
    public Square(final Composite composite, final int width, final int height) {
      super(composite, SWT.NONE);
      this.width = width;
      this.height = height;
      final PaintListener _function = (PaintEvent it) -> {
        it.gc.drawRectangle(0, 0, (width - 1), (height - 1));
      };
      this.addPaintListener(_function);
    }
    
    @Override
    public Point computeSize(final int wHint, final int hHint, final boolean changed) {
      return new Point(this.width, this.height);
    }
  }
  
  private final Node node;
  
  private final Optional<Image> icon;
  
  public RenderedNode(final Composite parent, final Node node, final Optional<Image> icon) {
    super(parent, SWT.NONE);
    this.node = node;
    this.icon = icon;
    RowLayout _rowLayout = new RowLayout(SWT.HORIZONTAL);
    final Procedure1<RowLayout> _function = (RowLayout it) -> {
      it.spacing = 0;
    };
    RowLayout _doubleArrow = ObjectExtensions.<RowLayout>operator_doubleArrow(_rowLayout, _function);
    this.setLayout(_doubleArrow);
    Composite _composite = new Composite(this, SWT.NONE);
    final Procedure1<Composite> _function_1 = (Composite it) -> {
      FillLayout _fillLayout = new FillLayout(SWT.VERTICAL);
      final Procedure1<FillLayout> _function_2 = (FillLayout it_1) -> {
        it_1.spacing = 0;
      };
      FillLayout _doubleArrow_1 = ObjectExtensions.<FillLayout>operator_doubleArrow(_fillLayout, _function_2);
      it.setLayout(_doubleArrow_1);
      final Consumer<Port> _function_3 = (Port port) -> {
        new RenderedNode.Square(it, 6, 6);
      };
      node.getInputPorts().forEach(_function_3);
      RowData _rowData = new RowData(6, 50);
      it.setLayoutData(_rowData);
    };
    ObjectExtensions.<Composite>operator_doubleArrow(_composite, _function_1);
    RenderedNode.Square _square = new RenderedNode.Square(this, 50, 50);
    final Procedure1<RenderedNode.Square> _function_2 = (RenderedNode.Square it) -> {
      RowData _rowData = new RowData(50, 50);
      it.setLayoutData(_rowData);
    };
    ObjectExtensions.<RenderedNode.Square>operator_doubleArrow(_square, _function_2);
    Composite _composite_1 = new Composite(this, SWT.NONE);
    final Procedure1<Composite> _function_3 = (Composite it) -> {
      FillLayout _fillLayout = new FillLayout(SWT.VERTICAL);
      final Procedure1<FillLayout> _function_4 = (FillLayout it_1) -> {
        it_1.spacing = 0;
      };
      FillLayout _doubleArrow_1 = ObjectExtensions.<FillLayout>operator_doubleArrow(_fillLayout, _function_4);
      it.setLayout(_doubleArrow_1);
      final Consumer<Port> _function_5 = (Port port) -> {
        new RenderedNode.Square(it, 6, 6);
      };
      node.getOutputPorts().forEach(_function_5);
      RowData _rowData = new RowData(6, 50);
      it.setLayoutData(_rowData);
    };
    ObjectExtensions.<Composite>operator_doubleArrow(_composite_1, _function_3);
    this.setSize(((6 + 50) + 6), 50);
    this.addListener(SWT.MouseDown, this);
    this.addMouseListener(new MouseListener() {
      @Override
      public void mouseDoubleClick(final MouseEvent e) {
        throw new UnsupportedOperationException("TODO: auto-generated method stub");
      }
      
      @Override
      public void mouseDown(final MouseEvent e) {
        throw new UnsupportedOperationException("TODO: auto-generated method stub");
      }
      
      @Override
      public void mouseUp(final MouseEvent e) {
        throw new UnsupportedOperationException("TODO: auto-generated method stub");
      }
    });
  }
  
  @Override
  public void handleEvent(final Event event) {
    InputOutput.<Event>println(event);
  }
  
  @Override
  public Point computeSize(final int wHint, final int hHint, final boolean changed) {
    return new Point((((6 + 50) + 6) + 8), (50 + 8));
  }
}
