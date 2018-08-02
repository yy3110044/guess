package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.Sport;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface SportMapper {
    void add(Sport obj);
    void delete(int id);
    void update(Sport obj);
    Sport find(QueryCondition qc);
    Sport findById(int id);
    List<Sport> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
