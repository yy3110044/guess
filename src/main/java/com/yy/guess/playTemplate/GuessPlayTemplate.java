package com.yy.guess.playTemplate;

import java.util.ArrayList;
import java.util.List;
import com.yy.fast4j.JsonResultMap;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;

public interface GuessPlayTemplate {
	//返回此模版支持的玩法
	default List<GuessPlayType> getSupportGuessPlayTypes() {
		GuessPlayType[] guessPlayTypes = GuessPlayType.values();
		List<GuessPlayType> list = new ArrayList<GuessPlayType>();
		for(GuessPlayType guessPlayType : guessPlayTypes) {
			GuessPlayTemplate gpt = guessPlayType.getPlayTemplate();
			if(gpt != null && gpt.getClass() == this.getClass()) {
				list.add(guessPlayType);
			}
		}
		return list;
	}
	
	//此模版是否支持这个玩法
	default boolean isSupport(GuessPlayType guessPlayType) {
		GuessPlayTemplate gpt = guessPlayType.getPlayTemplate();
		if(gpt == null) {
			return false;
		} else {
			return this.getClass() == gpt.getClass();
		}
	}

	//返回描述
	default String getDescription() {
		return null;
	}

	//返回左队伍名
	default String getLeftName(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType, GuessPlayType type) {
		return versus.getLeftTeamName();
	}

	//返回右队伍名
	default String getRightName(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType, GuessPlayType type) {
		return versus.getRightTeamName();
	}

	//返回结果
	int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType, GuessPlayType type);
	
	//返回此模版需要的参数，不需要参数则返回null
	default List<TemplateParam> getTemplateParams() {
		return null;
	}
	
	//返回json参数字符串，如果没有参数返回null
	default String getParamJsonStr(JsonResultMap map) {
		List<TemplateParam> paramList = this.getTemplateParams();
		if(paramList != null) {
			
		} else {
			return null;
		}
	}
	
	//返回参数map，如果没有参数返回null
	default JsonResultMap getParamMap(String jsonStr) {
		return null;
	}
}