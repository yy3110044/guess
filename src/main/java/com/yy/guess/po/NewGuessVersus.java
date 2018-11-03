package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.NewGuessVersusStatus;

public class NewGuessVersus {
	private int id;
	private String name;
	private String logoUrl;
	private int itemId;
	private String itemName;
	private double returnRate = 1;
	private double betAmountMin = 0.01;
	private double betAmountMax = 99999;
	private double betAllAmount;
	private Date startTime;
	private Date endTime;
	private boolean betPause = false;
	private int winner = 0;
	private NewGuessVersusStatus status = NewGuessVersusStatus.未开始;
	private int superVersusId = 0;
	private int childVersusCount = 0;
	private Date createTime = new Date();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLogoUrl() {
		return logoUrl;
	}
	public void setLogoUrl(String logoUrl) {
		this.logoUrl = logoUrl;
	}
	public int getItemId() {
		return itemId;
	}
	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public double getReturnRate() {
		return returnRate;
	}
	public void setReturnRate(double returnRate) {
		this.returnRate = returnRate;
	}
	public double getBetAmountMin() {
		return betAmountMin;
	}
	public void setBetAmountMin(double betAmountMin) {
		this.betAmountMin = betAmountMin;
	}
	public double getBetAmountMax() {
		return betAmountMax;
	}
	public void setBetAmountMax(double betAmountMax) {
		this.betAmountMax = betAmountMax;
	}
	public double getBetAllAmount() {
		return betAllAmount;
	}
	public void setBetAllAmount(double betAllAmount) {
		this.betAllAmount = betAllAmount;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public boolean isBetPause() {
		return betPause;
	}
	public void setBetPause(boolean betPause) {
		this.betPause = betPause;
	}
	public int getWinner() {
		return winner;
	}
	public void setWinner(int winner) {
		this.winner = winner;
	}
	public NewGuessVersusStatus getStatus() {
		return status;
	}
	public void setStatus(NewGuessVersusStatus status) {
		this.status = status;
	}
	public int getSuperVersusId() {
		return superVersusId;
	}
	public void setSuperVersusId(int superVersusId) {
		this.superVersusId = superVersusId;
	}
	public int getChildVersusCount() {
		return childVersusCount;
	}
	public void setChildVersusCount(int childVersusCount) {
		this.childVersusCount = childVersusCount;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}