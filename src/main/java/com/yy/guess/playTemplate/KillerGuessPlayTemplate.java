package com.yy.guess.playTemplate;

import java.util.List;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;

/**
 * 人头击杀队伍模版，包括，首杀，十杀
 * @author yy
 *
 */
public class KillerGuessPlayTemplate implements GuessPlayTemplate {
	@Override
	public int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType, GuessPlayType type) {
		if(this.isSupport(type)) {
			switch(type) {
			case 第一局首杀: return boList.get(0).getFirstKillTeam();
			case 第二局首杀: return boList.get(1).getFirstKillTeam();
			case 第三局首杀: return boList.get(2).getFirstKillTeam();
			case 第四局首杀: return boList.get(3).getFirstKillTeam();
			case 第五局首杀: return boList.get(4).getFirstKillTeam();
			case 第一局十杀: return boList.get(0).getTenthKillTeam();
			case 第二局十杀: return boList.get(1).getTenthKillTeam();
			case 第三局十杀: return boList.get(2).getTenthKillTeam();
			case 第四局十杀: return boList.get(3).getTenthKillTeam();
			case 第五局十杀: return boList.get(4).getTenthKillTeam();
			default: throw new RuntimeException("不支持的玩法");
			}
		} else {
			throw new RuntimeException("不支持的玩法");
		}
	}
}