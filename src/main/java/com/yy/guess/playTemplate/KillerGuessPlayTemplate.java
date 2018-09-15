package com.yy.guess.playTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;

/**
 * 人头击杀队伍模版，包括，首杀，十杀
 * @author yy
 *
 */
public class KillerGuessPlayTemplate implements GuessPlayTemplate {
	private static final Logger logger = LogManager.getLogger(KillerGuessPlayTemplate.class);
	private Map<String, TemplateParamInfo> templateParamInfoMap;
	KillerGuessPlayTemplate() {
		templateParamInfoMap = new HashMap<String, TemplateParamInfo>();
		templateParamInfoMap.put("killNumber", new TemplateParamInfo("killNumber", "Enum", "竞猜第几杀", new String[]{"首杀", "十杀"}));
	}
	
	@Override
	public String getDescription() {
		return "竞猜首杀和十杀的队伍";
	}
	
	@Override
	public String getPlayTypeName(MatchVersus versus, MatchVersusBo bo, Map<String, String> paramMap) {
		String killNumber = paramMap.get("killNumber");
		if("首杀".equals(killNumber)) {
			return "第" + bo.getBo() + "局首杀队伍";
		} else if("十杀".equals(killNumber)) {
			return "第" + bo.getBo() + "局十杀队伍";
		} else {
			RuntimeException e = new RuntimeException("killNumber错误：" + killNumber);
			logger.error(e.toString());
			throw e;
		}
	}
	
	@Override
	public Map<String, TemplateParamInfo> getTemplateParamInfoMap() {
		return templateParamInfoMap;
	}

	@Override
	public int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType) {
		Map<String, String> map = this.getParamMap(playType.getParamStr());
		String killNumber = map.get("killNumber");
		if("首杀".equals(killNumber)) {
			return boList.get(playType.getBo() - 1).getFirstKillTeam();
		} else if("十杀".equals(killNumber)) {
			return boList.get(playType.getBo() - 1).getTenthKillTeam();
		} else {
			RuntimeException e = new RuntimeException("killNumber错误：" + killNumber);
			logger.error(e.toString());
			throw e;
		}
	}

	@Override
	public int getSupport() {
		return 1;
	}
}