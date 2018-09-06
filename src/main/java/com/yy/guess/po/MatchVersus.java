package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.MatchStatus;

public class MatchVersus {
	private int id;
	private String name;
	private int matchId;
	private String matchName;
	private int leftTeamId;
	private String leftTeamName;
	private int rightTeamId;
	private String rightTeamName;
	private Date startTime;
	private Date endTime;
	private MatchStatus status;
	private int boCount;
	private int realBoCount;
	private int result;
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
	public int getMatchId() {
		return matchId;
	}
	public void setMatchId(int matchId) {
		this.matchId = matchId;
	}
	public String getMatchName() {
		return matchName;
	}
	public void setMatchName(String matchName) {
		this.matchName = matchName;
	}
	public int getLeftTeamId() {
		return leftTeamId;
	}
	public void setLeftTeamId(int leftTeamId) {
		this.leftTeamId = leftTeamId;
	}
	public String getLeftTeamName() {
		return leftTeamName;
	}
	public void setLeftTeamName(String leftTeamName) {
		this.leftTeamName = leftTeamName;
	}
	public int getRightTeamId() {
		return rightTeamId;
	}
	public void setRightTeamId(int rightTeamId) {
		this.rightTeamId = rightTeamId;
	}
	public String getRightTeamName() {
		return rightTeamName;
	}
	public void setRightTeamName(String rightTeamName) {
		this.rightTeamName = rightTeamName;
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
	public MatchStatus getStatus() {
		return status;
	}
	public void setStatus(MatchStatus status) {
		this.status = status;
	}
	public int getBoCount() {
		return boCount;
	}
	public void setBoCount(int boCount) {
		this.boCount = boCount;
	}
	public int getRealBoCount() {
		return realBoCount;
	}
	public void setRealBoCount(int realBoCount) {
		this.realBoCount = realBoCount;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
