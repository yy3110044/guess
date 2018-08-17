package com.yy.guess.playTemplate;

import java.util.Arrays;
import com.yy.guess.util.Util;

public class TemplateParamInfo {
	private String name; //参数名
	private String type; //参数类型
	private String description; //参数作用介绍
	private String[] enumElement; //如果参数是枚举，这个代表枚举的元素
	private boolean required; //是否必须，默认为必须
	private String defaultValue; //如果不是必须的情况下，的默认值
	
	private static final String[] paramTypes = {"String", "Integer", "Double", "Enum"};
	static {
		Arrays.sort(paramTypes);//排序，用于二分查找
	}
	
	public TemplateParamInfo(String name, String type, String description) {
		this(name, type, description, null);
	}
	
	public TemplateParamInfo(String name, String type, String description, String[] enumElement) {
		this(name, type, description, enumElement, true);
	}
	
	public TemplateParamInfo(String name, String type, String description, String[] enumElement, boolean required) {
		this(name, type, description, enumElement, required, null);
	}

	public TemplateParamInfo(String name, String type, String description, String[] enumElement, boolean required, String defaultValue) {
		if(Arrays.binarySearch(paramTypes, type) < 0) {
			throw new RuntimeException("type只能是：String、Integer、Double、Enum");
		}
		this.name = name;
		this.type = type;
		this.description = description;
		this.enumElement = enumElement;
		this.required = required;
		this.defaultValue = defaultValue;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String[] getEnumElement() {
		return enumElement;
	}
	public void setEnumElement(String[] enumElement) {
		this.enumElement = enumElement;
	}
	public boolean isRequired() {
		return required;
	}
	public void setRequired(boolean required) {
		this.required = required;
	}
	public String getDefaultValue() {
		return defaultValue;
	}
	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	//检查值是否符合要求
	public boolean checkValue(String value) {
		if(value != null) { //值不为空
			switch(type) {
			case "Integer": return Util.isInteger(value);
			case "Double": return Util.isDouble(value);
			case "Enum": return Util.inArray(value, enumElement);
			case "String": return true;
			default: throw new RuntimeException("不存在的类型");
			}
		} else { //值为空
			if(required) {
				return false;
			} else {
				return true;
			}
		}
	}
}