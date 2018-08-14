package com.yy.guess.playTemplate;

import java.util.List;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;

/**
 * 玩法模版
 * @author yy
 *
 */
public abstract class AbstractPlayTemplate implements PlayTemplate {
	protected MatchVersus matchVersus;
	protected List<MatchVersusBo> boList;

	protected AbstractPlayTemplate(MatchVersus matchVersus, List<MatchVersusBo> boList) {
		this.matchVersus = matchVersus;
		this.boList = boList;
	}
}