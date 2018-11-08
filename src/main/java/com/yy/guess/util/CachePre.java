package com.yy.guess.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;

public class CachePre {
	private CachePre() {}
	public static final String GUESS_USERID_TO_TOKEN = "guess_userId_to_token";
	public static final String GUESS_TOKEN_TO_USERID = "guess_token_to_userId";
	
	public static final Map<Integer, NewGuessVersus> versusMap = new ConcurrentHashMap<>();
    public static final Map<Integer, NewGuessVersusItem> versusItemMap = new ConcurrentHashMap<>();

	//左方奖金池
	@Deprecated
	public static final String GUESS_LEFT_BONUS_POOL = "guess_left_bonus_pool";

	//右方奖金池
	@Deprecated
	public static final String GUESS_RIGHT_BONUS_POOL = "guess_right_bonus_pool";
}