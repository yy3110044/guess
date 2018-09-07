package com.yy.guess.service.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.MatchVersusBoMapper;
import com.yy.guess.mapper.MatchVersusMapper;
import com.yy.guess.mapper.PlayTypeMapper;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.service.MatchVersusService;
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
    private PlayTypeMapper ptm;

    @Override
    public void add(MatchVersus obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(MatchVersus obj) {
        mapper.update(obj);
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
		ptm.deleteByVersusId(id);
	}

	@Override
	public List<String> getDistinctName(int matchId) {
		List<String> list = mapper.getDistinctName(matchId);
		list.remove("");//移除空字符串
		return list;
	}
	
	//更新versus，删除playtpe，并重新生成versusbo
	@Override
	public void update(MatchVersus obj, List<MatchVersusBo> boList) {
		mapper.update(obj);
		mvbm.deleteByVersusId(obj.getId());
		mvbm.addList(boList);
		ptm.deleteByVersusId(obj.getId());
	}

	@Override
	public List<MatchVersus> queryInSportIdScroll(List<Integer> sportIdList, Date endTime, Date startTime, Page page) {
		if(sportIdList != null && sportIdList.size() == 0) {
			sportIdList = null;
		}
		if(endTime == null) {
			endTime = new Date();
		}
		return mapper.queryInSportIdScroll(sportIdList, endTime, startTime, page);
	}

	@Override
	public int queryInSportIdScrollCount(List<Integer> sportIdList, Date endTime, Date startTime) {
		if(sportIdList != null && sportIdList.size() == 0) {
			sportIdList = null;
		}
		if(endTime == null) {
			endTime = new Date();
		}
		return mapper.queryInSportIdScrollCount(sportIdList, endTime, startTime);
	}

	@Override
	public List<MatchVersus> queryInSportIdStartTime(List<Integer> sportIdList, Date startTime, Date endTime, Page page) {
		if(sportIdList != null && sportIdList.size() == 0) {
			sportIdList = null;
		}
		return mapper.queryInSportIdStartTime(sportIdList, startTime, endTime, page);
	}

	@Override
	public int queryInSportIdStartTimeCount(List<Integer> sportIdList, Date startTime, Date endTime) {
		if(sportIdList != null && sportIdList.size() == 0) {
			sportIdList = null;
		}
		return mapper.queryInSportIdStartTimeCount(sportIdList, startTime, endTime);
	}
}
