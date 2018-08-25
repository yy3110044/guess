package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.BetDirection;

public class Bet {
	private int id;
	private int versusId;
	private int playTypeId;
	private int userId;
	private String userName;
	private BetDirection betDirection;
	private double odds;
	private double betAmount;
	private double soldAmount;
	private boolean soldOut;
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
	public int getPlayTypeId() {
		return playTypeId;
	}
	public void setPlayTypeId(int playTypeId) {
		this.playTypeId = playTypeId;
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
	public BetDirection getBetDirection() {
		return betDirection;
	}
	public void setBetDirection(BetDirection betDirection) {
		this.betDirection = betDirection;
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
	public double getSoldAmount() {
		return soldAmount;
	}
	public void setSoldAmount(double soldAmount) {
		this.soldAmount = soldAmount;
	}
	public boolean isSoldOut() {
		return soldOut;
	}
	public void setSoldOut(boolean soldOut) {
		this.soldOut = soldOut;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Bet other = (Bet) obj;
		if (id != other.id)
			return false;
		return true;
	}
}