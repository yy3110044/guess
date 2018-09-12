package com.yy.guess.playTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;

/**
 * 竞猜击杀时间
 * @author yy
 *
 */
public class KillTimeGuessPlayTemplate implements GuessPlayTemplate {
	private Map<String, TemplateParamInfo> templateParamInfoMap;
	KillTimeGuessPlayTemplate() {
		templateParamInfoMap = new HashMap<String, TemplateParamInfo>();
		templateParamInfoMap.put("killNumber", new TemplateParamInfo("killNumber", "Enum", "竞猜第几杀", new String[]{"首杀(一血)", "十杀"}));
		templateParamInfoMap.put("intervalTime", new TemplateParamInfo("intervalTime", "Integer", "分隔时间(单位为秒)"));
	}
	
	@Override
	public String getLeftGuessName(MatchVersus versus, List<MatchVersusBo> boList, Map<String, String> paramMap) {
		int intervalTime = Integer.parseInt(paramMap.get("intervalTime"));
		return "小于" + formatTime(intervalTime);
	}
	
	@Override
	public String getRightGuessName(MatchVersus versus, List<MatchVersusBo> boList, Map<String, String> paramMap) {
		int intervalTime = Integer.parseInt(paramMap.get("intervalTime"));
		return "大于等于" + formatTime(intervalTime);
	}
	
	private String formatTime(int intervalTime) {
		return (intervalTime / 60) + "分" + (intervalTime % 60) + "秒";
	}
	
	@Override
	public String getDescription() {
		return "竞猜首杀和十杀的时间";
	}
	
	@Override
	public Map<String, TemplateParamInfo> getTemplateParamInfoMap() {
		return templateParamInfoMap;
	}

	@Override
	public int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType) {
		Map<String, String> map = this.getParamMap(playType.getParamStr());
		String killNumber = map.get("killNumber");
		int intervalTime = Integer.parseInt(map.get("intervalTime"));
		if("首杀(一血)".equals(killNumber)) {
			int killTime = boList.get(playType.getBo() - 1).getFirstKillTime();
			if(killTime < intervalTime) {
				return -1;
			} else {
				return 1;
			}
		} else if("十杀".equals(killNumber)) {
			int killTime = boList.get(playType.getBo() - 1).getTenthKillTime();
			if(killTime < intervalTime) {
				return -1;
			} else {
				return 1;
			}
		} else {
			throw new RuntimeException("killNumber错误：" + killNumber);
		}
	}
	
	@Override
	public int getSupport() {
		return 1;
	}
}