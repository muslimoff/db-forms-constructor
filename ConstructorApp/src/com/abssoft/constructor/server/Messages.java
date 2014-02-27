package com.abssoft.constructor.server;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.sql.SQLException;
import java.util.MissingResourceException;
import java.util.PropertyResourceBundle;

public class Messages {
	private static PropertyResourceBundle rb;
	static {
		try {
			InputStream is = Messages.class
					.getResourceAsStream("/com/abssoft/constructor/server/messages.properties");
			Reader reader = new InputStreamReader(is, "UTF-8");
			rb = new PropertyResourceBundle(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getMessage(String key) {
		try {
			return rb.getString(key);
		} catch (MissingResourceException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String getMessage(Exception ex) {
		String msg = "";
		try {
			String key = "";
			if (ex instanceof SQLException) {
				String exMsg = ex.getMessage();
				if (exMsg.contains("Closed Connection")
						|| exMsg.contains("Io exception"))
					key = "db.connection.error";
			}
			if (rb.containsKey(key))
				msg = rb.getString(key);
		} catch (MissingResourceException e) {
			e.printStackTrace();
		}
		if (msg.length() == 0)
			msg = Utils.getExceptionStackIntoString(ex);
		return msg.toString();
	}
}
