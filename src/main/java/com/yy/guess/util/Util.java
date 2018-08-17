package com.yy.guess.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class Util {
	private Util() {}

	public static boolean isInteger(String value) {
		try {
			Integer.valueOf(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	public static boolean isDouble(String value) {
		try {
			Double.valueOf(value);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	public static boolean isEnum(String value, Class<? extends Enum<?>> enumClass) {
		try {
			Method method = enumClass.getMethod("valueOf", String.class);
			method.invoke(null, value);
			return true;
		} catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
			return false;
		}
	}

	public static boolean inArray(String value, String[] strArray) {
		for(String str : strArray) {
			if(value.equals(str)) {
				return true;
			}
		}
		return false;
	}
}