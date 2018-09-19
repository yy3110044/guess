package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.BetDirection;
import com.yy.guess.po.enums.BetStatus;

public class Bet {
	private int id;
	private String orderNumber;
	private int versusId;
	private int bo;
	private int playTypeId;
	private int userId;
	private String userName;
	private BetDirection betDirection;
	private double leftOdds;
	private double rightOdds;
	private double betAmount;
	private double realPayBonus;
	private BetStatus status;
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
	public int getBo() {
		return bo;
	}
	public void setBo(int bo) {
		this.bo = bo;
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
	public double getLeftOdds() {
		return leftOdds;
	}
	public void setLeftOdds(double leftOdds) {
		this.leftOdds = leftOdds;
	}
	public double getRightOdds() {
		return rightOdds;
	}
	public void setRightOdds(double rightOdds) {
		this.rightOdds = rightOdds;
	}
	public double getBetAmount() {
		return betAmount;
	}
	public void setBetAmount(double betAmount) {
		this.betAmount = betAmount;
	}
	public double getRealPayBonus() {
		return realPayBonus;
	}
	public void setRealPayBonus(double realPayBonus) {
		this.realPayBonus = realPayBonus;
	}
	public BetStatus getStatus() {
		return status;
	}
	public void setStatus(BetStatus status) {
		this.status = status;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}