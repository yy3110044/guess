package com.yy.guess;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import com.yy.fast4j.CheckUserLoginInterceptor;
import com.yy.fast4j.LoginManager;
import com.yy.guess.interceptor.CheckAdminUserLoginInterceptor;
import com.yy.guess.util.CachePre;

@SpringBootApplication
public class Application extends SpringBootServletInitializer implements WebMvcConfigurer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(Application.class);
	}
	
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;

	/**
	 * 配置interceptor
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new CheckUserLoginInterceptor(redisTemplate, CachePre.GUESS_TOKEN_TO_USERID)).addPathPatterns("/user/**");
		registry.addInterceptor(new CheckAdminUserLoginInterceptor()).addPathPatterns("/administration/**");
	}
	
	@Value("${web.config.tokenExpirationTime:1296000000}")
	private long tokenExpirationTime;
	
	@Bean
	public LoginManager loginManager() {
		return new LoginManager(CachePre.GUESS_USERID_TO_TOKEN, CachePre.GUESS_TOKEN_TO_USERID, tokenExpirationTime, redisTemplate);
	}
}