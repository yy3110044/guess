package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.Match;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface MatchMapper {
    void add(Match obj);
    void delete(int id);
    void update(Match obj);
    Match find(QueryCondition qc);
    Match findById(int id);
    List<Match> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
