package com.yy.guess.component;

import java.util.Date;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.yy.fast4j.QueryCondition;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.enums.MatchStatus;
import com.yy.guess.service.MatchVersusService;

/**
 * 对阵开时间监控，
 * 将时间到了的对阵的状态变更为进行中
 * @author 49803
 *
 */
@Component
public class MatchVersusStartTimeMonitor implements Runnable {
	private static final Logger logger = LogManager.getLogger(MatchVersusStartTimeMonitor.class);
	
	private ScheduledExecutorService service;
	
	private long delay = 60000; //延迟，单位：毫秒
	
	@Autowired
	private MatchVersusService mvs;
	
	public MatchVersusStartTimeMonitor() {
		service = Executors.newSingleThreadScheduledExecutor();
	}
	
	@PostConstruct
	public void start() {
		service.scheduleWithFixedDelay(this, delay, delay, TimeUnit.MILLISECONDS);
	}
	
	@PreDestroy
	public void stop() {
		service.shutdownNow();
	}

	@Override
	public void run() {
		try {
			QueryCondition qc = new QueryCondition();
			qc.addCondition("status", "=", MatchStatus.未开始);
			qc.addCondition("autoSwitchStatus", "=", true);
			qc.addCondition("startTime", "<=", new Date());
			List<MatchVersus> list = mvs.query(qc);
			for(MatchVersus versus : list) {
				mvs.updateStatus(MatchStatus.进行中, versus.getId());
			}
		} catch (Exception e) {
			logger.error(e.toString());
		}
	}
}