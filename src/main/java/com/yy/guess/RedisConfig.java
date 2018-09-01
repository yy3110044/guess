package com.yy.guess;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.jedis.JedisClientConfiguration;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * redis配置
 * @author 49803
 *
 */
@Configuration
public class RedisConfig {
	
	//jedis连接池配置
	@Bean
	public JedisPoolConfig jedisPoolConfig() {
		JedisPoolConfig config = new JedisPoolConfig();
		config.setMaxTotal(500);//最大分配的连接数
		config.setMaxIdle(150);//最大空闲连接数
		config.setMinIdle(50);//最小空闲连接数
		config.setMaxWaitMillis(5000);//建立连接的最大等待时间，超过时间，就会抛出异常，负数表示一直等待
		config.setTestOnBorrow(true);//当调用borrow Object方法时，是否进行有效性检查
		config.setTestWhileIdle(true);//连接空闲时是否检验正确性
		return config;
	}

	//jedis连接池
	@Bean
	public JedisPool jedisPool(JedisPoolConfig jedisPoolConfig) {
		return new JedisPool(jedisPoolConfig, "127.0.0.1", 6379);
	}

	//jedis连接工厂
	@Bean
	public JedisConnectionFactory jedisConnectionFactory(JedisPoolConfig jedisPoolConfig) {
		//服务地址以及，密码配置
		RedisStandaloneConfiguration redisStandaloneConfiguration = new RedisStandaloneConfiguration();
		redisStandaloneConfiguration.setHostName("127.0.0.1");
		redisStandaloneConfiguration.setPort(6379);

		//客户端配置
		JedisClientConfiguration jedisClientConfiguration = JedisClientConfiguration.builder().usePooling().poolConfig(jedisPoolConfig).build();

		//jedis连接工厂
		JedisConnectionFactory jedisConnectionFactory = new JedisConnectionFactory(redisStandaloneConfiguration, jedisClientConfiguration);
		return jedisConnectionFactory;
	}

	private StringRedisSerializer stringRedisSerializer = new StringRedisSerializer();
	//用json字符串序列化
	private GenericJackson2JsonRedisSerializer genericJackson2JsonRedisSerializer = new GenericJackson2JsonRedisSerializer();
	//使用jdk提供的序列化，保存的对象必须实现Serializable接口
	//private JdkSerializationRedisSerializer jdkSerializationRedisSerializer = new JdkSerializationRedisSerializer();
	//redisTemplate配置
	@Bean
	public RedisTemplate<String, Object> redisTemplate(JedisConnectionFactory jedisConnectionFactory) {
		RedisTemplate<String, Object> objectRedisTemplate = new RedisTemplate<String, Object>();

		//如果不配置Serializer，那么存储的时候缺省使用String，如果用User类型存储，那么会提示错误
		objectRedisTemplate.setKeySerializer(stringRedisSerializer);
		objectRedisTemplate.setHashKeySerializer(stringRedisSerializer);

		objectRedisTemplate.setValueSerializer(genericJackson2JsonRedisSerializer);
		objectRedisTemplate.setHashValueSerializer(genericJackson2JsonRedisSerializer);

		//开启事务
		objectRedisTemplate.setEnableTransactionSupport(true);
		objectRedisTemplate.setConnectionFactory(jedisConnectionFactory);
        return objectRedisTemplate;
	}
}