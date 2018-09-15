package com.yy.guess.playTemplate;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import com.yy.fast4j.Fast4jUtils;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;

/**
 * 玩法模版接口
 * @author yy
 *
 */
public interface GuessPlayTemplate {
	//返回描述
	default String getDescription() {
		return "";
	}
	
	//应用到playType中的name
	default String getPlayTypeName(MatchVersus versus, MatchVersusBo bo, Map<String, String> paramMap) {
		return this.getDescription();
	}

	//返回左队伍名
	default String getLeftGuessName(MatchVersus versus, MatchVersusBo bo, Map<String, String> paramMap) {
		return versus.getLeftTeamName();
	}

	//返回右队伍名
	default String getRightGuessName(MatchVersus versus, MatchVersusBo bo, Map<String, String> paramMap) {
		return versus.getRightTeamName();
	}

	//返回支持：-1代表支持所有、0代表只支持总对阵、1代表只支持bo对阵
	int getSupport();
	
	//返回结果
	int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType);
	
	//返回此模版需要的参数Map，不需要参数则返回null
	default Map<String, TemplateParamInfo> getTemplateParamInfoMap() {
		return null;
	}

	//返回此模版需要的参数，不需要参数则返回null
	default Collection<TemplateParamInfo> getTemplateParamInfos() {
		Map<String, TemplateParamInfo> paramInfoMap = this.getTemplateParamInfoMap();
		if(paramInfoMap != null) {
			return paramInfoMap.values();
		} else {
			return null;
		}
	}

	//检验参数map是否符合要求
	default boolean checkParamMap(Map<String, String> map) {
		Collection<TemplateParamInfo> paramInfos = this.getTemplateParamInfos();
		if(paramInfos != null) { //参数不为空，说明需要参数
			for(TemplateParamInfo paramInfo : paramInfos) {
				String value = map.get(paramInfo.getName());
				if(!paramInfo.checkValue(value)) {
					return false;
				}
			}
			return true;
		} else { //不需要参数直接返回true;
			return true;
		}
	}
	
	//设置默认值
	default void setDefaultValue(Map<String, String> map) {
		Collection<TemplateParamInfo> paramInfos = this.getTemplateParamInfos();
		if(paramInfos != null) {
			for(TemplateParamInfo paramInfo : paramInfos) {
				String defaultValue = paramInfo.getDefaultValue();
				if(defaultValue != null) {
					String value = map.get(paramInfo.getName());
					if(value == null) {
						map.put(paramInfo.getName(), defaultValue);
					}
				}
			}
		}
	}
	
	//根据参数名返回TemplateParamInfo对象，没有则返回null
	default TemplateParamInfo getTemplateParamInfo(String name) {
		Map<String, TemplateParamInfo> paramInfoMap = this.getTemplateParamInfoMap();
		if(paramInfoMap != null) {
			return paramInfoMap.get(name);
		} else {
			return null;
		}
	}

	//返回json参数字符串，如果没有参数返回null
	default String getParamJsonStr(Map<String, String> map) {
		if(!this.checkParamMap(map)) {
			throw new RuntimeException("参数不符合要求");
		}
		
		//设置默认值
		this.setDefaultValue(map);
		
		return Fast4jUtils.ObjecttoJson(map);
	}

	//返回参数map，如果没有参数返回null
	default Map<String, String> getParamMap(String jsonStr) {
		@SuppressWarnings("unchecked")
		Map<String, String> map = Fast4jUtils.jsonToObject(jsonStr, Map.class);
		
		if(!this.checkParamMap(map)) {
			throw new RuntimeException("参数不符合要求");
		}
		
		//设置默认值
		this.setDefaultValue(map);
		
		return map;
	}
}