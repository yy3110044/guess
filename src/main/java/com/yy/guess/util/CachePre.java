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
}