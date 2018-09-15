package com.yy.guess.playTemplate;

import java.util.List;
import java.util.Map;
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
		return "获胜者";
	}
	
	@Override
	public String getPlayTypeName(MatchVersus versus, MatchVersusBo bo, Map<String, String> paramMap) {
		if(bo == null) {
			return "获胜者";
		} else {
			return "第" + bo.getBo() + "局获胜者";
		}
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