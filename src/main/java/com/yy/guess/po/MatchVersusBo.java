package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.MatchStatus;

public class MatchVersusBo {
	private int id;
	private int versusId;
	private int bo;
	private MatchStatus status;
	private int result;
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
	public int getBo() {
		return bo;
	}
	public void setBo(int bo) {
		this.bo = bo;
	}
	public MatchStatus getStatus() {
		return status;
	}
	public void setStatus(MatchStatus status) {
		this.status = status;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
