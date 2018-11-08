package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.NewGuessBetStatus;

public class NewGuessBet {
	private int id;
	private String orderNumber;
	private int versusId;
	private int versusItemId;
	private int userId;
	private String userName;
	private double odds;
	private double betAmount;
	private NewGuessBetStatus status = NewGuessBetStatus.未结算;
	private double payBonus;
	private Date createTime = new Date();

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public int getVersusId() {
		return versusId;
	}
	public void setVersusId(int versusId) {
		this.versusId = versusId;
	}
	public int getVersusItemId() {
		return versusItemId;
	}
	public void setVersusItemId(int versusItemId) {
		this.versusItemId = versusItemId;
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
	public double getOdds() {
		return odds;
	}
	public void setOdds(double odds) {
		this.odds = odds;
	}
	public double getBetAmount() {
		return betAmount;
	}
	public void setBetAmount(double betAmount) {
		this.betAmount = betAmount;
	}
	public NewGuessBetStatus getStatus() {
		return status;
	}
	public void setStatus(NewGuessBetStatus status) {
		this.status = status;
	}
	public double getPayBonus() {
		return payBonus;
	}
	public void setPayBonus(double payBonus) {
		this.payBonus = payBonus;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}