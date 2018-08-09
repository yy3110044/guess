package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.yy.guess.po.MatchVersusBo;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface MatchVersusBoMapper {
    void add(MatchVersusBo obj);
    void delete(int id);
    void update(MatchVersusBo obj);
    MatchVersusBo find(QueryCondition qc);
    MatchVersusBo findById(int id);
    List<MatchVersusBo> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    
    void addList(@Param("boList") List<MatchVersusBo> boList);
    void deleteByVersusId(int versusId);
}
