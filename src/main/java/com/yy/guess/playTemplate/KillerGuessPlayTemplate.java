package com.yy.guess.playTemplate;

import java.util.List;
import com.yy.fast4j.JsonResultMap;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;

/**
 * 人头击杀队伍模版，包括，首杀，十杀
 * @author yy
 *
 */
public class KillerGuessPlayTemplate implements GuessPlayTemplate {
	KillerGuessPlayTemplate() {
	}

	@Override
	public int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType, GuessPlayType type) {
		if(this.isSupport(type)) {
			switch(type) {
			
			}
		} else {
			throw new RuntimeException("不支持的玩法");
		}
	}
	
	@Override
	public String getParamJsonStr(JsonResultMap map) {
		
	}
	
	@Override
	public JsonResultMap getParamMap(String jsonStr) {
		
	}
}