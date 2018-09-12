package com.yy.guess.po;

import java.util.Date;

public class PlayType {
	private int id;
	private int versusId;
	private String name;
	private int bo;
	private String paramStr;
	private String templateClass;
	private boolean pause;
	private boolean guessStart;
	private String leftGuessName;
	private String rightGuessName;
	private double leftWinRate;
	private double rightWinRate;
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
	public boolean isPause() {
		return pause;
	}
	public void setPause(boolean pause) {
		this.pause = pause;
	}
	public boolean isGuessStart() {
		return guessStart;
	}
	public void setGuessStart(boolean guessStart) {
		this.guessStart = guessStart;
	}
	public String getLeftGuessName() {
		return leftGuessName;
	}
	public void setLeftGuessName(String leftGuessName) {
		this.leftGuessName = leftGuessName;
	}
	public String getRightGuessName() {
		return rightGuessName;
	}
	public void setRightGuessName(String rightGuessName) {
		this.rightGuessName = rightGuessName;
	}
	public double getLeftWinRate() {
		return leftWinRate;
	}
	public void setLeftWinRate(double leftWinRate) {
		this.leftWinRate = leftWinRate;
	}
	public double getRightWinRate() {
		return rightWinRate;
	}
	public void setRightWinRate(double rightWinRate) {
		this.rightWinRate = rightWinRate;
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