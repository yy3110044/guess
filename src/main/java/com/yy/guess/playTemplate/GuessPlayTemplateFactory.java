package com.yy.guess.playTemplate;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class GuessPlayTemplateFactory {
	private GuessPlayTemplateFactory() {};

	private static final Map<String, GuessPlayTemplate> playTemplateMap = new HashMap<String, GuessPlayTemplate>();
	static {
		//初始化所有模版
		playTemplateMap.put(KillTimeGuessPlayTemplate.class.getName(), new KillTimeGuessPlayTemplate());
		playTemplateMap.put(KillerGuessPlayTemplate.class.getName(), new KillerGuessPlayTemplate());
		playTemplateMap.put(WinnerGuessPlayTemplate.class.getName(), new WinnerGuessPlayTemplate());
	}

	public static GuessPlayTemplate getGuessPlayTemplate(String className) {
		return playTemplateMap.get(className);
	}

	public static Set<Entry<String, GuessPlayTemplate>> getAllTemplate() {
		return playTemplateMap.entrySet();
	}
}