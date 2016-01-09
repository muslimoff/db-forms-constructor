package com.abssoft.constructor.client.common;

import com.abssoft.constructor.client.data.Utils;

public class KeyIdentifier extends com.smartgwt.client.core.KeyIdentifier {
	private String title;

	/**
	 * Возвращает <code>KeyIdentifier</code> с установленными свойствами
	 * CtrlKey, AltKey, ShiftKey и KeyName(Chr).
	 * 
	 * @param dbKey
	 *            - строка вида [Ctrl+][Alt+][Shift+]Chr. Регистр не важен.
	 */
	public KeyIdentifier(String dbKey) {
		dbKey = dbKey.toUpperCase();
		//setCtrlKey(false); setAltKey(false); setShiftKey(false); //mm20160111 SGWT5.1.d - Добавлена инициализация по причине ошибки в getAltKey при неопределенном параметре
		Utils.debug("KeyIdentifier(dbKey): " + dbKey);
		if (dbKey.contains("CTRL+")) {
			setCtrlKey(true);
			dbKey = dbKey.replaceAll("CTRL\\+", "");
		}
		if (dbKey.contains("ALT+")) {
			setAltKey(true);
			dbKey = dbKey.replaceAll("ALT\\+", "");
		}
		if (dbKey.contains("SHIFT+")) {
			setShiftKey(true);
			dbKey = dbKey.replaceAll("SHIFT\\+", "");
		}
		setKeyName(dbKey);

		// по причине ошибки в getAltKey при неопределенном параметре
		// title = (getCtrlKey() ? "Ctrl+" : "") + (getAltKey() ? "Alt+" : "") + (getShiftKey() ? "Shift+" : "") + getKeyName();
		title = (getAttributeAsBoolean("ctrlKey") ? "Ctrl+" : "") + (getAttributeAsBoolean("altKey") ? "Alt+" : "") + (getAttributeAsBoolean("shiftKey") ? "Shift+" : "") + getKeyName();
		
	}

	/**
	 * @return String title - комбинация клавиш, отображаемая пользователю
	 */
	public String getTitle() {
		return title;
	}
}