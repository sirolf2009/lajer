package com.sirolf2009.lajer.ide

import com.sirolf2009.lajer.ide.xtend.XtendFormatter
import org.eclipse.swt.SWT
import org.eclipse.swt.custom.StyledText
import org.eclipse.swt.widgets.Composite

class XtendEditor extends StyledText {

	new(Composite parent) {
		super(parent, SWT.MULTI.bitwiseOr(SWT.V_SCROLL).bitwiseOr(SWT.H_SCROLL))
		addKeyListener(new XtendFormatter(display))
	}

}
