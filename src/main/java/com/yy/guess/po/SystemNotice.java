package com.yy.guess.po;

import java.util.Date;

public class SystemNotice {
	private int id;
	private String content;
	private int top;
	private Date createTime = new Date();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getTop() {
		return top;
	}
	public void setTop(int top) {
		this.top = top;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}