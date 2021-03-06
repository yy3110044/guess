package com.yy.guess.po;

import java.util.Date;
import com.yy.guess.po.enums.UserLoginType;

public class User {
	private int id;
	private String userName;
	private String passWord;
	private String withdrawPassWord;
	private double balance;
	private String nickName;
	private String realName;
	private boolean realNameLock;
	private String qq;
	private String phone;
	private String email;
	private Date registTime;
	private String lastLoginIp;
	private Date lastLoginTime;
	private UserLoginType lastLoginType;
	private int superUserId;
	private double rebateRate;
	private double subordinateDefaultRebateRate;
	private Date createTime = new Date();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getWithdrawPassWord() {
		return withdrawPassWord;
	}
	public void setWithdrawPassWord(String withdrawPassWord) {
		this.withdrawPassWord = withdrawPassWord;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public boolean isRealNameLock() {
		return realNameLock;
	}
	public void setRealNameLock(boolean realNameLock) {
		this.realNameLock = realNameLock;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegistTime() {
		return registTime;
	}
	public void setRegistTime(Date registTime) {
		this.registTime = registTime;
	}
	public String getLastLoginIp() {
		return lastLoginIp;
	}
	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	public Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public UserLoginType getLastLoginType() {
		return lastLoginType;
	}
	public void setLastLoginType(UserLoginType lastLoginType) {
		this.lastLoginType = lastLoginType;
	}
	public int getSuperUserId() {
		return superUserId;
	}
	public void setSuperUserId(int superUserId) {
		this.superUserId = superUserId;
	}
	public double getRebateRate() {
		return rebateRate;
	}
	public void setRebateRate(double rebateRate) {
		this.rebateRate = rebateRate;
	}
	public double getSubordinateDefaultRebateRate() {
		return subordinateDefaultRebateRate;
	}
	public void setSubordinateDefaultRebateRate(double subordinateDefaultRebateRate) {
		this.subordinateDefaultRebateRate = subordinateDefaultRebateRate;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}