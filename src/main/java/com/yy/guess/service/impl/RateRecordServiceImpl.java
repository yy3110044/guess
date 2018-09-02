package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.RateRecordMapper;
import com.yy.guess.po.RateRecord;
import com.yy.guess.service.RateRecordService;
import com.yy.fast4j.QueryCondition;

@Repository("rateRecordService")
@Transactional
public class RateRecordServiceImpl implements RateRecordService {
    @Autowired
    private RateRecordMapper mapper;

    @Override
    public void add(RateRecord obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(RateRecord obj) {
        mapper.update(obj);
    }

    @Override
    public RateRecord find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public RateRecord findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<RateRecord> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/
}
