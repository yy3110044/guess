package com.yy.guess.playTemplate;

public class TemplateParam {
	private String name;
	private TemplateParamType type;
	private boolean required;
	private String defaultValue;

	public TemplateParam(String name, TemplateParamType type, boolean required, String defaultValue) {
		this.name = name;
		this.type = type;
		this.required = required;
		this.defaultValue = defaultValue;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public TemplateParamType getType() {
		return type;
	}
	public void setType(TemplateParamType type) {
		this.type = type;
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

	public enum TemplateParamType {
		INT, STRING, FLOAT
	}
}