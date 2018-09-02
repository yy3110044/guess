package com.yy.guess.po;

import java.util.Date;

/**
 * 平台抽成记录
 * @author 49803
 *
 */
public class RateRecord {
	private int id;
	private int userId;
	private int betId;
	private double amount;
	private double platformRate;
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
	public int getBetId() {
		return betId;
	}
	public void setBetId(int betId) {
		this.betId = betId;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public double getPlatformRate() {
		return platformRate;
	}
	public void setPlatformRate(double platformRate) {
		this.platformRate = platformRate;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}