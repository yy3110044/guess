package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.MatchVersusBoMapper;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.enums.MatchStatus;
import com.yy.guess.service.MatchVersusBoService;
import com.yy.guess.service.PlayTypeService;
import com.yy.fast4j.QueryCondition;

@Repository("matchVersusBoService")
@Transactional
public class MatchVersusBoServiceImpl implements MatchVersusBoService {
    @Autowired
    private MatchVersusBoMapper mapper;
    
    @Autowired
    private PlayTypeService pts;

    @Override
    public void add(MatchVersusBo obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(MatchVersusBo obj) {
        mapper.update(obj);
        if(obj.getStatus() == MatchStatus.已结束 || obj.getStatus() == MatchStatus.未比赛) {//关闭投注接口
        	pts.stopGuessByVersusIdAndBo(obj.getVersusId(), obj.getBo());
        }
        pts.updateStatusAndResultByVersusIdAndBo(obj.getStatus(), obj.getVersusId(), obj.getBo());
    }

    @Override
    public MatchVersusBo find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public MatchVersusBo findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<MatchVersusBo> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
