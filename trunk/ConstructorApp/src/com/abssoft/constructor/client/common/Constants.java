package com.abssoft.constructor.client.common;

import com.google.gwt.core.client.GWT;

/**
 * Содержит глобальные константы для приложения. В дальнейшем заменить на
 * настройки, хранящиеся в БД.
 * 
 * @author User
 * 
 */
public class Constants {
	//public static final String DEFAULT_COLUMN_WIDTH = "100";
	//public static final int FETCH_SIZE = 100;
	//public static final int GRID_SCROLL_REDRAW_DELAY = 5;
	//public static final float DRAW_AHEAD_RATIO = (float) 1.5;

	public static String getDefaultIconPath() {
		return GWT.isScript() ? "/ConstructorApp/resources/icons/" : "/resources/icons/";
	}
}
