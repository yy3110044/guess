package com.yy.guess.po;

import java.util.Date;

public class UserNotice {
	private int id;
	private int userId;
	private String userName;
	private String title;
	private String content;
	private boolean hadRead;
	private Date readTime;
	private boolean systemNotice;
	private Date createTime = new Date();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isHadRead() {
		return hadRead;
	}
	public void setHadRead(boolean hadRead) {
		this.hadRead = hadRead;
	}
	public Date getReadTime() {
		return readTime;
	}
	public void setReadTime(Date readTime) {
		this.readTime = readTime;
	}
	public boolean isSystemNotice() {
		return systemNotice;
	}
	public void setSystemNotice(boolean systemNotice) {
		this.systemNotice = systemNotice;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}