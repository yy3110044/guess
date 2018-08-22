package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.TradeFlow;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface TradeFlowMapper {
    void add(TradeFlow obj);
    void delete(int id);
    void update(TradeFlow obj);
    TradeFlow find(QueryCondition qc);
    TradeFlow findById(int id);
    List<TradeFlow> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
