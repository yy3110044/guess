package com.yy.guess;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;
import com.yy.guess.component.ConfigComponent;
import com.yy.guess.component.GuessSettleComponent;
import com.yy.guess.service.BetService;

@Component
public class AppRunner implements CommandLineRunner, ApplicationRunner, Ordered {
	@Autowired
	private GuessSettleComponent guessSettleComponent;
	
	@Autowired
	private ConfigComponent cfgCom;
	
	@Autowired
	private BetService bs;

	/**
	 * 实现Ordered接口，可以实现，不同的操作按顺序启动
	 */
	@Override
	public int getOrder() {
		return 0;
	}

	/**
	 * 实现ApplicationRunner接口，也可以实现开机启动，ApplicationArguments对参数作了进一步封装
	 */
	@Override
	public void run(ApplicationArguments args) throws Exception {
		
	}

	//实现CommandLineRunner接口，并重写run方法，就可以在spring boot启动后执行一些操作，
	//同时在要在实现类上加上@Component注解，这里直接用
	@Override
	public void run(String... args) throws Exception {
		bs.loadStartedGuess(); //加载已开启的竞猜
		cfgCom.loadConfigToCache(); //加载配置到redis
		guessSettleComponent.start(); //
	}
}