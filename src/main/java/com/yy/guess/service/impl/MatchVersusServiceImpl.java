package com.yy.guess.service.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.MatchVersusBoMapper;
import com.yy.guess.mapper.MatchVersusMapper;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.enums.MatchStatus;
import com.yy.guess.service.MatchVersusService;
import com.yy.guess.service.PlayTypeService;
import com.yy.guess.util.QueryResult;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;

@Repository("matchVersusService")
@Transactional
public class MatchVersusServiceImpl implements MatchVersusService {
    @Autowired
    private MatchVersusMapper mapper;
    
    @Autowired
    private MatchVersusBoMapper mvbm;
    
    @Autowired
    private PlayTypeService pts;

    @Override
    public void add(MatchVersus obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public MatchVersus find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public MatchVersus findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<MatchVersus> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public void add(MatchVersus obj, List<MatchVersusBo> boList) {
		mapper.add(obj);
		for(MatchVersusBo bo : boList) {
			bo.setVersusId(obj.getId());
		}
		mvbm.addList(boList);
	}

	@Override
	public void deleteVersus(int id) {
		mapper.delete(id);
		mvbm.deleteByVersusId(id);
		pts.deleteByVersusId(id);
	}

	@Override
	public List<String> getDistinctName(int matchId) {
		List<String> list = mapper.getDistinctName(matchId);
		list.remove("");//移除空字符串
		return list;
	}
	
	@Override
	public void update(MatchVersus obj, List<MatchVersusBo> boList) {
		mapper.update(obj);
		if(boList != null && boList.size() > 0) {
			mvbm.deleteByVersusId(obj.getId());
			mvbm.addList(boList);
			pts.deleteByVersusId(obj.getId());
		} else {
			if(obj.getStatus() == MatchStatus.已结束 || obj.getStatus() == MatchStatus.未比赛) { //关闭下注接口
				pts.stopGuessByVersusId(obj.getId());//主盘口结将关闭此对阵下的所有玩法
			}
			pts.updateStatusAndResultByVersusIdAndBo(obj.getStatus(), obj.getId(), 0);
		}
	}

	@Override
	public void updateStatus(MatchStatus status, int versusId) {
		mapper.updateStatus(status, versusId);
		pts.updateStatusAndResultByVersusIdAndBo(status, versusId, 0);
	}

	@Override
	public void updateAutoSwitchStatus(boolean autoSwitchStatus, int versusId) {
		mapper.updateAutoSwitchStatus(autoSwitchStatus, versusId);
	}

	@Override
	public QueryResult<MatchVersus> queryInSportId(List<Integer> sportIdList, int status, Date startTime, Date endTime, Page page) {
		if(sportIdList != null && sportIdList.size() <= 0) {
			sportIdList = null;
		}
		List<MatchVersus> list = mapper.queryInSportId(sportIdList, status, startTime, endTime, page);
		if(page != null) {
			page.setRowCount(mapper.queryInSportIdCount(sportIdList, status, startTime, endTime));
		}
		return new QueryResult<MatchVersus>(list, page);
	}
}
