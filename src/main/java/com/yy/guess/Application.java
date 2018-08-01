package com.yy.guess;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import com.yy.fast4j.Cache;
import com.yy.fast4j.CheckUserLoginInterceptor;
import com.yy.fast4j.LoginManager;
import com.yy.guess.util.CachePre;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@SpringBootApplication
public class Application extends SpringBootServletInitializer implements WebMvcConfigurer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(Application.class);
	}
	
	/**
	 * 配置redis(单服务器)
	 * @return
	 */
	@Bean(name="jedisPool")
	public JedisPool getJedisPool() {
		JedisPoolConfig config = new JedisPoolConfig();
		config.setMaxTotal(20);//最大分配的对象数
		config.setMaxIdle(10);//最大能够保持idel状态的对象数
		config.setMinIdle(7);//最小空闲的对象数
		config.setMaxWaitMillis(1000);//当池内没有返回对象时，最大等待时间
		config.setLifo(false);//是否启用Lifo。如果不设置，默认为true。
		config.setTestOnBorrow(false);//当调用borrow Object方法时，是否进行有效性检查
		return new JedisPool(config, "localhost", 6379);
	}

	/**
	 * 配置interceptor
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new CheckUserLoginInterceptor(cache, CachePre.GUESS_TOKEN_TO_USERID)).addPathPatterns("/user/**");
	}
	
	@Autowired
	private Cache cache;

	@Value("${web.config.tokenExpirationTime:1296000000}")
	private long tokenExpirationTime;
	
	@Bean
	public com.yy.fast4j.RedisCache redisCache() {
		return new com.yy.fast4j.RedisCache(getJedisPool());
	}

	@Bean
	public LoginManager loginManager() {
		return new LoginManager(CachePre.GUESS_USERID_TO_TOKEN, CachePre.GUESS_TOKEN_TO_USERID, tokenExpirationTime, cache);
	}
}