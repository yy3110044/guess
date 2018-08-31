package com.yy.guess.po;

import java.util.Date;

public class PlayType {
	private int id;
	private int versusId;
	private String name;
	private int bo;
	private String paramStr;
	private String templateClass;
	private boolean guessStart;
	private double leftOdds;
	private double rightOdds;
	private double leftBonusPool;
	private double rightBonusPool;
	private boolean fixedOdds;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBo() {
		return bo;
	}
	public void setBo(int bo) {
		this.bo = bo;
	}
	public String getParamStr() {
		return paramStr;
	}
	public void setParamStr(String paramStr) {
		this.paramStr = paramStr;
	}
	public String getTemplateClass() {
		return templateClass;
	}
	public void setTemplateClass(String templateClass) {
		this.templateClass = templateClass;
	}
	public boolean isGuessStart() {
		return guessStart;
	}
	public void setGuessStart(boolean guessStart) {
		this.guessStart = guessStart;
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
	public double getLeftBonusPool() {
		return leftBonusPool;
	}
	public void setLeftBonusPool(double leftBonusPool) {
		this.leftBonusPool = leftBonusPool;
	}
	public double getRightBonusPool() {
		return rightBonusPool;
	}
	public void setRightBonusPool(double rightBonusPool) {
		this.rightBonusPool = rightBonusPool;
	}
	public boolean isFixedOdds() {
		return fixedOdds;
	}
	public void setFixedOdds(boolean fixedOdds) {
		this.fixedOdds = fixedOdds;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}