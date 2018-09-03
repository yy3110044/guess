package com.yy.guess.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import com.yy.fast4j.Fast4jUtils;
import com.yy.guess.component.ConfigComponent;

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
	
	public static ConfigComponent getConfigCom(ServletContext sc) {
		return Fast4jUtils.getBean(ConfigComponent.class, sc);
	}
	
	public static boolean isMobile(HttpServletRequest req) {
		String userAgent = req.getHeader("User-Agent");
		boolean isMobile = false;
		if(userAgent != null) {
			userAgent = userAgent.toLowerCase();
			for(String mobileAgent : mobileAgents) {
				if(userAgent.indexOf(mobileAgent) >= 0) {
					isMobile = true;
					break;
				}
			}
		}
		return isMobile;
	}
	
	private static final String[] mobileAgents = {"iphone", "android", "phone", "mobile", "wap", "netfront", "java", 
			"opera mobi", "opera mini", "ucweb", "windows ce", "symbian", "series", "webos", "sony", "blackberry", "dopod",
			"nokia", "samsung", "palmsource", "xda", "pieplus", "meizu", "midp", "cldc", "motorola", "foma",
			"docomo", "up.browser", "up.link", "blazer", "helio", "hosin", "huawei", "novarra", "coolpad", "webos",
			"techfaith", "palmsource", "alcatel", "amoi", "ktouch", "nexian", "ericsson", "philips", "sagem",
			"wellcom", "bunjalloo", "maui", "smartphone", "iemobile", "spice", "bird", "zte-", "longcos",
			"pantech", "gionee", "portalmmm", "jig browser", "hiptop", "benq", "haier", "^lct", "320x320",
			"240x320", "176x220", "w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac",
			"blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs",
			"kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi",
			"mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port",
			"prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem",
			"smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v",
			"voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-", "Googlebot-Mobile"};
}