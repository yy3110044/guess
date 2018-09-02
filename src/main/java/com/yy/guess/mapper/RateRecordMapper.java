package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.RateRecord;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface RateRecordMapper {
    void add(RateRecord obj);
    void delete(int id);
    void update(RateRecord obj);
    RateRecord find(QueryCondition qc);
    RateRecord findById(int id);
    List<RateRecord> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
