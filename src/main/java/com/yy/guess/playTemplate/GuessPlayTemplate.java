package com.yy.guess.playTemplate;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import com.yy.fast4j.Fast4jUtils;
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
		return "";
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
	
	//返回此模版需要的参数Map，不需要参数则返回null
	default Map<String, TemplateParamInfo<?>> getTemplateParamInfoMap() {
		return null;
	}
	
	//返回此模版需要的参数，不需要参数则返回null
	default Collection<TemplateParamInfo<?>> getTemplateParamInfos() {
		Map<String, TemplateParamInfo<?>> paramInfoMap = this.getTemplateParamInfoMap();
		if(paramInfoMap != null) {
			return paramInfoMap.values();
		} else {
			return null;
		}
	}
	
	//检验参数map是否符合要求
	default boolean checkParamMap(JsonResultMap map) {
		Collection<TemplateParamInfo<?>> paramInfos = this.getTemplateParamInfos();
		if(paramInfos != null) { //参数不为空，说明需要参数
			for(TemplateParamInfo<?> paramInfo : paramInfos) {
				Object value = map.get(paramInfo.getName());
				if(value == null) { //没有这个参数
					if(paramInfo.isRequired()) { //些参数是必须的确没有，返回false
						return false;
					}
				} else {
					if(value.getClass() != paramInfo.getTypeClass()) {
						return false;
					}
				}
			}
			return true;
		} else { //不需要参数直接返回true;
			return true;
		}
	}
	
	//设置默认值
	default void setDefaultValue(JsonResultMap map) {
		Collection<TemplateParamInfo<?>> paramInfos = this.getTemplateParamInfos();
		if(paramInfos != null) {
			for(TemplateParamInfo<?> paramInfo : paramInfos) {
				Object defaultValue = paramInfo.getDefaultValue();
				if(defaultValue != null) {
					Object value = map.get(paramInfo.getName());
					if(value == null) {
						map.set(paramInfo.getName(), defaultValue);
					}
				}
			}
		}
	}
	
	//根据参数名返回TemplateParamInfo对象，没有则返回null
	default TemplateParamInfo<?> getTemplateParamInfo(String name) {
		Map<String, TemplateParamInfo<?>> paramInfoMap = this.getTemplateParamInfoMap();
		if(paramInfoMap != null) {
			return paramInfoMap.get(name);
		} else {
			return null;
		}
	}
	
	//返回json参数字符串，如果没有参数返回null
	default String getParamJsonStr(JsonResultMap map) {
		if(!this.checkParamMap(map)) {
			throw new RuntimeException("参数不符合要求");
		}
		
		//设置默认值
		this.setDefaultValue(map);
		
		return Fast4jUtils.ObjecttoJson(map);
	}
	
	//返回参数map，如果没有参数返回null
	default JsonResultMap getParamMap(String jsonStr) {
		JsonResultMap map = Fast4jUtils.jsonToObject(jsonStr, JsonResultMap.class);
		
		if(!this.checkParamMap(map)) {
			throw new RuntimeException("参数不符合要求");
		}
		
		//设置默认值
		this.setDefaultValue(map);
		
		return map;
	}
}