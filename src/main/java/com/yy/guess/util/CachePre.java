package com.yy.guess.util;

public class CachePre {
	private CachePre() {}
	public static final String GUESS_USERID_TO_TOKEN = "guess_userId_to_token";
	public static final String GUESS_TOKEN_TO_USERID = "guess_token_to_userId";

	//web配置
	public static final String GUESS_CONFIG = "guess_config";

	//左方奖金池
	public static final String GUESS_LEFT_BONUS_POOL = "guess_left_bonus_pool";

	//右方奖金池
	public static final String GUESS_RIGHT_BONUS_POOL = "guess_right_bonus_pool";

	//左方下注未售出队列
	public static final String GUESS_LEFT_UNSOLD_BET_QUEUE = "guess_left_unsold_bet_queue";

	//右方下注未售出队列
	public static final String GUESS_RIGHT_UNSOLD_BET_QUEUE = "guess_right_unsold_bet_queue";
	
	//左方最新赔率
	public static final String GUESS_LEFT_NEWEST_ODDS = "guess_left_newest_odds";
	
	//右方最新赔率
	public static final String GUESS_RIGHT_NEWEST_ODDS = "guess_right_newest_odds";
}