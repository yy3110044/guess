package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.MatchStatus;

public class PlayType {
	private int id;
	private int versusId;
	private String name;
	private int bo;
	private int versusBoId;
	private MatchStatus status;
	private int result;
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
	private double changeOddsMin;
	private double changeOddsMax;
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
	public int getVersusBoId() {
		return versusBoId;
	}
	public void setVersusBoId(int versusBoId) {
		this.versusBoId = versusBoId;
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
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + bo;
		long temp;
		temp = Double.doubleToLongBits(changeOddsMax);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		temp = Double.doubleToLongBits(changeOddsMin);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((createTime == null) ? 0 : createTime.hashCode());
		result = prime * result + (fixedOdds ? 1231 : 1237);
		result = prime * result + (guessStart ? 1231 : 1237);
		result = prime * result + id;
		temp = Double.doubleToLongBits(leftBonusPool);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((leftGuessName == null) ? 0 : leftGuessName.hashCode());
		temp = Double.doubleToLongBits(leftWinRate);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((paramStr == null) ? 0 : paramStr.hashCode());
		result = prime * result + (pause ? 1231 : 1237);
		result = prime * result + this.result;
		temp = Double.doubleToLongBits(rightBonusPool);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((rightGuessName == null) ? 0 : rightGuessName.hashCode());
		temp = Double.doubleToLongBits(rightWinRate);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((templateClass == null) ? 0 : templateClass.hashCode());
		result = prime * result + versusBoId;
		result = prime * result + versusId;
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
		PlayType other = (PlayType) obj;
		if (bo != other.bo)
			return false;
		if (Double.doubleToLongBits(changeOddsMax) != Double.doubleToLongBits(other.changeOddsMax))
			return false;
		if (Double.doubleToLongBits(changeOddsMin) != Double.doubleToLongBits(other.changeOddsMin))
			return false;
		if (createTime == null) {
			if (other.createTime != null)
				return false;
		} else if (!createTime.equals(other.createTime))
			return false;
		if (fixedOdds != other.fixedOdds)
			return false;
		if (guessStart != other.guessStart)
			return false;
		if (id != other.id)
			return false;
		if (Double.doubleToLongBits(leftBonusPool) != Double.doubleToLongBits(other.leftBonusPool))
			return false;
		if (leftGuessName == null) {
			if (other.leftGuessName != null)
				return false;
		} else if (!leftGuessName.equals(other.leftGuessName))
			return false;
		if (Double.doubleToLongBits(leftWinRate) != Double.doubleToLongBits(other.leftWinRate))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (paramStr == null) {
			if (other.paramStr != null)
				return false;
		} else if (!paramStr.equals(other.paramStr))
			return false;
		if (pause != other.pause)
			return false;
		if (result != other.result)
			return false;
		if (Double.doubleToLongBits(rightBonusPool) != Double.doubleToLongBits(other.rightBonusPool))
			return false;
		if (rightGuessName == null) {
			if (other.rightGuessName != null)
				return false;
		} else if (!rightGuessName.equals(other.rightGuessName))
			return false;
		if (Double.doubleToLongBits(rightWinRate) != Double.doubleToLongBits(other.rightWinRate))
			return false;
		if (status != other.status)
			return false;
		if (templateClass == null) {
			if (other.templateClass != null)
				return false;
		} else if (!templateClass.equals(other.templateClass))
			return false;
		if (versusBoId != other.versusBoId)
			return false;
		if (versusId != other.versusId)
			return false;
		return true;
	}
}