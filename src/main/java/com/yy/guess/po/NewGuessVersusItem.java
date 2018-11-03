package com.yy.guess.po;

import java.util.Date;

public class NewGuessVersusItem {
	private int id;
	private String name;
	private int versusId;
	private double betAmount;
	private boolean fixedOdds = false;
	private double odds;
	private double changeOddsMin;
	private double changeOddsMax;
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
	public int getVersusId() {
		return versusId;
	}
	public void setVersusId(int versusId) {
		this.versusId = versusId;
	}
	public double getBetAmount() {
		return betAmount;
	}
	public void setBetAmount(double betAmount) {
		this.betAmount = betAmount;
	}
	public boolean isFixedOdds() {
		return fixedOdds;
	}
	public void setFixedOdds(boolean fixedOdds) {
		this.fixedOdds = fixedOdds;
	}
	public double getOdds() {
		return odds;
	}
	public void setOdds(double odds) {
		this.odds = odds;
	}
	public double getChangeOddsMin() {
		return changeOddsMin;
	}
	public void setChangeOddsMin(double changeOddsMin) {
		this.changeOddsMin = changeOddsMin;
	}
	public double getChangeOddsMax() {
		return changeOddsMax;
	}
	public void setChangeOddsMax(double changeOddsMax) {
		this.changeOddsMax = changeOddsMax;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}