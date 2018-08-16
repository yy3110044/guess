package com.yy.guess.playTemplate;

public class TemplateParamInfo<T> {
	private String name; //参数名
	private Class<T> typeClass; //参数类型
	private String description; //参数作用介绍
	private boolean required; //是否必须，默认为必须
	private T defaultValue; //如果不是必须的情况下，的默认值
	
	public TemplateParamInfo(String name, Class<T> typeClass, String description) {
		this(name, typeClass, description, true);
	}
	
	public TemplateParamInfo(String name, Class<T> typeClass, String description, boolean required) {
		this(name, typeClass, description, required, null);
	}
	
	public TemplateParamInfo(String name, Class<T> typeClass, String description, boolean required, T defaultValue) {
		if(typeClass != String.class && typeClass != Integer.class && typeClass != Long.class && typeClass != Float.class && typeClass != Double.class) {
			throw new RuntimeException("typeClass只能是String、Integer、Long、Float、Double");
		}
		this.name = name;
		this.typeClass = typeClass;
		this.description = description;
		this.required = required;
		this.defaultValue = defaultValue;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Class<T> getTypeClass() {
		return typeClass;
	}
	public void setTypeClass(Class<T> typeClass) {
		this.typeClass = typeClass;
	}
	public boolean isRequired() {
		return required;
	}
	public void setRequired(boolean required) {
		this.required = required;
	}
	public T getDefaultValue() {
		return defaultValue;
	}
	public void setDefaultValue(T defaultValue) {
		this.defaultValue = defaultValue;
	}
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public T parseValue(String value) {
		if(typeClass == String.class) {
			return typeClass.cast(value);
		} else if(typeClass == Integer.class) {
			return typeClass.cast(Integer.valueOf(value));
		} else if(typeClass == Long.class) {
			return typeClass.cast(Long.valueOf(value));
		} else if(typeClass == Float.class) {
			return typeClass.cast(Float.valueOf(value));
		} else if(typeClass == Double.class) {
			return typeClass.cast(Double.valueOf(value));
		} else {
			throw new RuntimeException("typeClass只能是String、Integer、Long、Float、Double");
		}
	}
	
	public boolean checkValue(String value) {
		if(typeClass == String.class) {
			return true;
		} else if(typeClass == Integer.class) {
			try {
				Integer.valueOf(value);
				return true;
			} catch (NumberFormatException e) {
				return false;
			}
		} else if(typeClass == Long.class) {
			try {
				Long.valueOf(value);
				return true;
			} catch (NumberFormatException e) {
				return false;
			}
		} else if(typeClass == Float.class) {
			try {
				Float.valueOf(value);
				return true;
			} catch (NumberFormatException e) {
				return false;
			}
		} else if(typeClass == Double.class) {
			try {
				Double.valueOf(value);
				return true;
			} catch (NumberFormatException e) {
				return false;
			}
		} else {
			throw new RuntimeException("typeClass只能是String、Integer、Long、Float、Double");
		}
	}
}