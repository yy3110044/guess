package com.yy.guess.playTemplate;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class GuessPlayTemplateFactory {
	private GuessPlayTemplateFactory() {};
	
	private static final Logger logger = LogManager.getLogger(GuessPlayTemplateFactory.class);
	private static final Map<Class<? extends GuessPlayTemplate>, GuessPlayTemplate> playTemplateMap = new ConcurrentHashMap<Class<? extends GuessPlayTemplate>, GuessPlayTemplate>();
	public static GuessPlayTemplate getGuessPlayTemplate(Class<? extends GuessPlayTemplate> guessPlayTemplateClass) {
		GuessPlayTemplate guessPlayTemplate = playTemplateMap.get(guessPlayTemplateClass);
		if(guessPlayTemplate == null) {
			try {
				guessPlayTemplate = guessPlayTemplateClass.newInstance();
				playTemplateMap.put(guessPlayTemplateClass, guessPlayTemplate);
			} catch (InstantiationException | IllegalAccessException e) {
				logger.error(e.toString());
				throw new RuntimeException(e);
			}
		}
		return guessPlayTemplate;
	}
	public static GuessPlayTemplate getGuessPlayTemplate(String className) {
		try {
			@SuppressWarnings("unchecked")
			Class<? extends GuessPlayTemplate> cls = (Class<? extends GuessPlayTemplate>)Class.forName(className);
			return getGuessPlayTemplate(cls);
		} catch (ClassNotFoundException e) {
			logger.error(e.toString());
			throw new RuntimeException(e);
		}
	}
}