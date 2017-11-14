package com.sirolf2009.lajer.plugin;

import com.sirolf2009.lajer.plugin.LajerEditor;
import java.util.List;
import java.util.function.Consumer;
import org.eclipse.core.resources.IFile;
import org.eclipse.core.resources.IProject;
import org.eclipse.jdt.core.IAnnotation;
import org.eclipse.jdt.core.ICompilationUnit;
import org.eclipse.jdt.core.IJavaProject;
import org.eclipse.jdt.core.IPackageFragment;
import org.eclipse.jdt.core.IPackageFragmentRoot;
import org.eclipse.jdt.core.IType;
import org.eclipse.jdt.core.JavaCore;
import org.eclipse.swt.SWT;
import org.eclipse.swt.dnd.DND;
import org.eclipse.swt.dnd.DragSource;
import org.eclipse.swt.dnd.DragSourceEvent;
import org.eclipse.swt.dnd.DragSourceListener;
import org.eclipse.swt.dnd.FileTransfer;
import org.eclipse.swt.dnd.Transfer;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Table;
import org.eclipse.swt.widgets.TableItem;
import org.eclipse.ui.IEditorInput;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.IFileEditorInput;
import org.eclipse.ui.IPartListener;
import org.eclipse.ui.IWorkbenchPart;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.part.ViewPart;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ObjectExtensions;
import org.eclipse.xtext.xbase.lib.Procedures.Procedure1;

@SuppressWarnings("all")
public class Library extends ViewPart implements IPartListener {
  private Table library;
  
  @Override
  public void createPartControl(final Composite parent) {
    Table _table = new Table(parent, SWT.V_SCROLL);
    final Procedure1<Table> _function = (Table it) -> {
      DragSource _dragSource = new DragSource(it, ((DND.DROP_COPY | DND.DROP_NONE) | DND.DROP_MOVE));
      final Procedure1<DragSource> _function_1 = (DragSource it_1) -> {
        FileTransfer _instance = FileTransfer.getInstance();
        it_1.setTransfer(new Transfer[] { _instance });
        it_1.addDragListener(new DragSourceListener() {
          @Override
          public void dragFinished(final DragSourceEvent arg0) {
          }
          
          @Override
          public void dragSetData(final DragSourceEvent event) {
            try {
              Object _data = Library.this.library.getSelection()[0].getData();
              final IType node = ((IType) _data);
              final String[] data = new String[1];
              data[0] = Library.this.getProject().getFile(node.getPath().removeFirstSegments(1)).getRawLocationURI().toURL().getPath();
              event.data = data;
            } catch (Throwable _e) {
              throw Exceptions.sneakyThrow(_e);
            }
          }
          
          @Override
          public void dragStart(final DragSourceEvent arg0) {
          }
        });
      };
      ObjectExtensions.<DragSource>operator_doubleArrow(_dragSource, _function_1);
    };
    Table _doubleArrow = ObjectExtensions.<Table>operator_doubleArrow(_table, _function);
    this.library = _doubleArrow;
    PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().addPartListener(this);
    this.updateNodeList();
  }
  
  public void updateNodeList() {
    int _itemCount = this.library.getItemCount();
    int _minus = (_itemCount - 1);
    this.library.remove(0, _minus);
    this.library.redraw();
    try {
      final Consumer<IType> _function = (IType node) -> {
        TableItem _tableItem = new TableItem(this.library, SWT.NONE);
        final Procedure1<TableItem> _function_1 = (TableItem it) -> {
          it.setText(node.getFullyQualifiedName());
          it.setData(node);
        };
        ObjectExtensions.<TableItem>operator_doubleArrow(_tableItem, _function_1);
      };
      this.getNodes().forEach(_function);
    } catch (final Throwable _t) {
      if (_t instanceof Exception) {
        final Exception e = (Exception)_t;
      } else {
        throw Exceptions.sneakyThrow(_t);
      }
    }
    this.library.redraw();
  }
  
  public Iterable<IType> getNodes() {
    try {
      Iterable<IType> _xblockexpression = null;
      {
        final IJavaProject project = JavaCore.create(this.getProject());
        final Function1<IPackageFragment, Boolean> _function = (IPackageFragment it) -> {
          try {
            int _kind = it.getKind();
            return Boolean.valueOf((_kind == IPackageFragmentRoot.K_SOURCE));
          } catch (Throwable _e) {
            throw Exceptions.sneakyThrow(_e);
          }
        };
        final Function1<IPackageFragment, Iterable<IType>> _function_1 = (IPackageFragment it) -> {
          try {
            final Function1<ICompilationUnit, List<IType>> _function_2 = (ICompilationUnit it_1) -> {
              try {
                return IterableExtensions.<IType>toList(((Iterable<IType>)Conversions.doWrapArray(it_1.getAllTypes())));
              } catch (Throwable _e) {
                throw Exceptions.sneakyThrow(_e);
              }
            };
            return IterableExtensions.<ICompilationUnit, IType>flatMap(((Iterable<ICompilationUnit>)Conversions.doWrapArray(it.getCompilationUnits())), _function_2);
          } catch (Throwable _e) {
            throw Exceptions.sneakyThrow(_e);
          }
        };
        final Function1<IType, Boolean> _function_2 = (IType it) -> {
          try {
            final Function1<IAnnotation, Boolean> _function_3 = (IAnnotation it_1) -> {
              return Boolean.valueOf(((it_1.getElementName().equals("Component") || it_1.getElementName().equals("Splitter")) || it_1.getElementName().equals("Operation")));
            };
            int _size = IterableExtensions.size(IterableExtensions.<IAnnotation>filter(((Iterable<IAnnotation>)Conversions.doWrapArray(it.getAnnotations())), _function_3));
            return Boolean.valueOf((_size > 0));
          } catch (Throwable _e) {
            throw Exceptions.sneakyThrow(_e);
          }
        };
        _xblockexpression = IterableExtensions.<IType>filter(IterableExtensions.<IPackageFragment, IType>flatMap(IterableExtensions.<IPackageFragment>filter(((Iterable<IPackageFragment>)Conversions.doWrapArray(project.getPackageFragments())), _function), _function_1), _function_2);
      }
      return _xblockexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public IProject getProject() {
    IProject _xblockexpression = null;
    {
      final IEditorPart editor = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getActivePage().getActiveEditor();
      IEditorInput _editorInput = editor.getEditorInput();
      final IFileEditorInput input = ((IFileEditorInput) _editorInput);
      final IFile file = input.getFile();
      _xblockexpression = file.getProject();
    }
    return _xblockexpression;
  }
  
  @Override
  public void setFocus() {
    this.library.setFocus();
  }
  
  @Override
  public void partActivated(final IWorkbenchPart part) {
    if ((part instanceof LajerEditor)) {
      this.updateNodeList();
    }
  }
  
  @Override
  public void partBroughtToTop(final IWorkbenchPart part) {
  }
  
  @Override
  public void partClosed(final IWorkbenchPart part) {
  }
  
  @Override
  public void partDeactivated(final IWorkbenchPart part) {
  }
  
  @Override
  public void partOpened(final IWorkbenchPart part) {
  }
}
