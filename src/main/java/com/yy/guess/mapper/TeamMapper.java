package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.Team;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface TeamMapper {
    void add(Team obj);
    void delete(int id);
    void update(Team obj);
    Team find(QueryCondition qc);
    Team findById(int id);
    List<Team> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
