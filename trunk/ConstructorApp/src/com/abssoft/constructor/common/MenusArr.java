package com.abssoft.constructor.common;

import java.util.ArrayList;

import com.abssoft.constructor.common.metadata.MenuMD;
import com.google.gwt.user.client.rpc.IsSerializable;

public class MenusArr extends ArrayList<MenuMD> implements IsSerializable,
		HasActionStatus {

	/**
	 * 
	 */
	private static final long serialVersionUID = -635243718510124368L;
	private IconsArr icons;
	private ActionStatus status;

	/**
	 * @param icons
	 *            the icons to set
	 */
	public void setIcons(IconsArr icons) {
		this.icons = icons;
	}

	/**
	 * @return the icons
	 */
	public IconsArr getIcons() {
		return icons;
	}

	@Override
	public void setStatus(ActionStatus status) {
		this.status = status;
	}

	@Override
	public ActionStatus getStatus() {
		return status;
	}

}
