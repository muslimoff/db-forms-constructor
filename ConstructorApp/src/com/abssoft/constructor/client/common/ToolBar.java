package com.abssoft.constructor.client.common;

import com.smartgwt.client.widgets.Button;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.layout.HLayout;

public class ToolBar extends HLayout {
	private int height;

	// private Button[] members;

	public ToolBar(int heigth) {
		this.height = heigth;
		super.setHeight(heigth);
		super.setBackgroundImage("[SKIN]ListGrid/header_Selected.png");
		// super.setBackgroundColor("#98BDCD");
	}

	public void addMember(Button button) {
		button.setHeight(height);
		super.addMember(button);
	}

	public void addMembers(Button... buttons) {
		for (Button b : buttons) {
			this.addMember(b);
		}
	}

	public void addMembers(IButton... buttons) {
		for (IButton b : buttons) {
			this.addMember(b);
		}
	}

	public Integer getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}
}
