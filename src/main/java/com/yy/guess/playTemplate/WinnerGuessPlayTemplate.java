package com.yy.guess.playTemplate;

import java.util.List;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.enums.MatchStatus;

/**
 * 猜胜负
 * @author yy
 *
 */
public class WinnerGuessPlayTemplate implements GuessPlayTemplate {
	WinnerGuessPlayTemplate() {
	}
	
	@Override
	public int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType, GuessPlayType type) {
		if(this.isSupport(type)) {
			switch(type) {
			case 胜负:
			case 第一局胜负:
			case 第二局胜负:
			case 第三局胜负:
			case 第四局胜负:
			case 第五局胜负:
				int bo = type.getBo();
				if(bo > 0) {
					MatchVersusBo versusBo = boList.get(bo - 1);
					if(versusBo.getStatus() == MatchStatus.已结束) {
						return versusBo.getResult();
					} else {
						throw new RuntimeException("比赛未结束");
					}
				} else {
					if(versus.getStatus() == MatchStatus.已结束) {
						return versus.getResult();
					} else {
						throw new RuntimeException("比赛未结束");
					}
				}
			default: throw new RuntimeException("不支持的玩法");
			}
		} else {
			throw new RuntimeException("不支持的玩法");
		}
	}
}