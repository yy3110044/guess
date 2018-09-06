package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.yy.guess.po.MatchVersus;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface MatchVersusMapper {
    void add(MatchVersus obj);
    void delete(int id);
    void update(MatchVersus obj);
    MatchVersus find(QueryCondition qc);
    MatchVersus findById(int id);
    List<MatchVersus> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    
    @Select("select distinct(name) from guess_match_versus where matchId = #{matchId}")
    List<String> getDistinctName(int matchId);
}
