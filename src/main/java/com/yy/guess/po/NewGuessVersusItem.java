package com.yy.guess.po;

import java.util.Date;

public class NewGuessVersusItem {
	private int id;
	private String name;
	private int versusId;
	private double betAmount;
	private double allPayBonus;
	private boolean useFixedOdds = false;
	private double fixedOdds;
	private double changeOdds;
	private double changeOddsPlusRatio;
	private double changeOddsPlusValue;
	private int changeOddsPlusStrategy;
	private double changeOddsMinusRatio;
	private double changeOddsMinusValue;
	private int changeOddsMinusStrategy;
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
	public double getAllPayBonus() {
		return allPayBonus;
	}
	public void setAllPayBonus(double allPayBonus) {
		this.allPayBonus = allPayBonus;
	}
	public boolean isUseFixedOdds() {
		return useFixedOdds;
	}
	public void setUseFixedOdds(boolean useFixedOdds) {
		this.useFixedOdds = useFixedOdds;
	}
	public double getFixedOdds() {
		return fixedOdds;
	}
	public void setFixedOdds(double fixedOdds) {
		this.fixedOdds = fixedOdds;
	}
	public double getChangeOdds() {
		return changeOdds;
	}
	public void setChangeOdds(double changeOdds) {
		this.changeOdds = changeOdds;
	}
	public double getChangeOddsPlusRatio() {
		return changeOddsPlusRatio;
	}
	public void setChangeOddsPlusRatio(double changeOddsPlusRatio) {
		this.changeOddsPlusRatio = changeOddsPlusRatio;
	}
	public double getChangeOddsPlusValue() {
		return changeOddsPlusValue;
	}
	public void setChangeOddsPlusValue(double changeOddsPlusValue) {
		this.changeOddsPlusValue = changeOddsPlusValue;
	}
	public int getChangeOddsPlusStrategy() {
		return changeOddsPlusStrategy;
	}
	public void setChangeOddsPlusStrategy(int changeOddsPlusStrategy) {
		this.changeOddsPlusStrategy = changeOddsPlusStrategy;
	}
	public double getChangeOddsMinusRatio() {
		return changeOddsMinusRatio;
	}
	public void setChangeOddsMinusRatio(double changeOddsMinusRatio) {
		this.changeOddsMinusRatio = changeOddsMinusRatio;
	}
	public double getChangeOddsMinusValue() {
		return changeOddsMinusValue;
	}
	public void setChangeOddsMinusValue(double changeOddsMinusValue) {
		this.changeOddsMinusValue = changeOddsMinusValue;
	}
	public int getChangeOddsMinusStrategy() {
		return changeOddsMinusStrategy;
	}
	public void setChangeOddsMinusStrategy(int changeOddsMinusStrategy) {
		this.changeOddsMinusStrategy = changeOddsMinusStrategy;
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