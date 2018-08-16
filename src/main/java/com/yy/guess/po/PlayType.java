package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.playTemplate.GuessPlayType;

public class PlayType {
	private int id;
	private int versusId;
	private GuessPlayType playType;
	private int bo;
	private String params;
	private Date createTime = new Date();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getVersusId() {
		return versusId;
	}
	public void setVersusId(int versusId) {
		this.versusId = versusId;
	}
	public GuessPlayType getPlayType() {
		return playType;
	}
	public void setPlayType(GuessPlayType playType) {
		this.playType = playType;
	}
	public int getBo() {
		return bo;
	}
	public void setBo(int bo) {
		this.bo = bo;
	}
	public String getParams() {
		return params;
	}
	public void setParams(String params) {
		this.params = params;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}