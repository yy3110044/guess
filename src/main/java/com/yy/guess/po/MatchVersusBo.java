package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.MatchStatus;

public class MatchVersusBo {
	private int id;
	private int versusId;
	private int bo;
	private MatchStatus status;
	private int result;
	private int firstKillTeam;
	private int firstKillTime;
	private int tenthKillTeam;
	private int tenthKillTime;
	private int leftTeamKillCount;
	private int rightTeamKillCount;
	private int matchTime;
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
	public int getBo() {
		return bo;
	}
	public void setBo(int bo) {
		this.bo = bo;
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
	public int getFirstKillTeam() {
		return firstKillTeam;
	}
	public void setFirstKillTeam(int firstKillTeam) {
		this.firstKillTeam = firstKillTeam;
	}
	public int getFirstKillTime() {
		return firstKillTime;
	}
	public void setFirstKillTime(int firstKillTime) {
		this.firstKillTime = firstKillTime;
	}
	public int getTenthKillTeam() {
		return tenthKillTeam;
	}
	public void setTenthKillTeam(int tenthKillTeam) {
		this.tenthKillTeam = tenthKillTeam;
	}
	public int getTenthKillTime() {
		return tenthKillTime;
	}
	public void setTenthKillTime(int tenthKillTime) {
		this.tenthKillTime = tenthKillTime;
	}
	public int getLeftTeamKillCount() {
		return leftTeamKillCount;
	}
	public void setLeftTeamKillCount(int leftTeamKillCount) {
		this.leftTeamKillCount = leftTeamKillCount;
	}
	public int getRightTeamKillCount() {
		return rightTeamKillCount;
	}
	public void setRightTeamKillCount(int rightTeamKillCount) {
		this.rightTeamKillCount = rightTeamKillCount;
	}
	public int getMatchTime() {
		return matchTime;
	}
	public void setMatchTime(int matchTime) {
		this.matchTime = matchTime;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
