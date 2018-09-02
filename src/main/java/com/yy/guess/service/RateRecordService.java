package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.RateRecord;
import com.yy.fast4j.QueryCondition;

public interface RateRecordService {
    void add(RateRecord obj);
    void delete(int id);
    void update(RateRecord obj);
    RateRecord find(QueryCondition qc);
    RateRecord findById(int id);
    List<RateRecord> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
