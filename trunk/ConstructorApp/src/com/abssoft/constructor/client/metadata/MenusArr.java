package com.abssoft.constructor.client.metadata;

import java.util.HashMap;

import com.google.gwt.user.client.rpc.IsSerializable;

//extends ArrayList<MenuMD>
public class MenusArr extends HashMap<String, MenuMD> implements IsSerializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -635243718510124368L;
	private IconsArr icons;

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
}
