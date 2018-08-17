package com.yy.guess.playTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;

/**
 * 人头击杀队伍模版，包括，首杀，十杀
 * @author yy
 *
 */
public class KillerGuessPlayTemplate implements GuessPlayTemplate {
	private Map<String, TemplateParamInfo> templateParamInfoMap;
	KillerGuessPlayTemplate() {
		templateParamInfoMap = new HashMap<String, TemplateParamInfo>();
		templateParamInfoMap.put("killNumber", new TemplateParamInfo("killNumber", "Enum", "竞猜第几杀", new String[]{"首杀(一血)", "十杀"}));
	}
	
	@Override
	public String getDescription() {
		return "竞猜首杀和十杀的队伍";
	}
	
	@Override
	public Map<String, TemplateParamInfo> getTemplateParamInfoMap() {
		return templateParamInfoMap;
	}

	@Override
	public int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType) {
		Map<String, String> map = this.getParamMap(playType.getParamStr());
		String killNumber = map.get("killNumber");
		if("首杀(一血)".equals(killNumber)) {
			return boList.get(playType.getBo() - 1).getFirstKillTeam();
		} else if("十杀".equals(killNumber)) {
			return boList.get(playType.getBo() - 1).getTenthKillTeam();
		} else {
			throw new RuntimeException("killNumber错误：" + killNumber);
		}
	}

	@Override
	public int getSupport() {
		return 1;
	}
}