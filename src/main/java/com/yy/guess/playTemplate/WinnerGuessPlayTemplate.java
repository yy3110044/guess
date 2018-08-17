package com.yy.guess.playTemplate;

import java.util.List;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.PlayType;

/**
 * 猜胜负
 * @author yy
 *
 */
public class WinnerGuessPlayTemplate implements GuessPlayTemplate {
	WinnerGuessPlayTemplate() {
	}

	@Override
	public String getDescription() {
		return "竞猜胜负";
	}

	@Override
	public int getResult(MatchVersus versus, List<MatchVersusBo> boList, PlayType playType) {
		int bo = playType.getBo();
		if(bo > 0) {
			MatchVersusBo versusBo = boList.get(bo - 1);
			return versusBo.getResult();
		} else {
			return versus.getResult();
		}
	}

	@Override
	public int getSupport() {
		return -1;
	}
}