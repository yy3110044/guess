package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.PlayType;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface PlayTypeMapper {
    void add(PlayType obj);
    void delete(int id);
    void update(PlayType obj);
    PlayType find(QueryCondition qc);
    PlayType findById(int id);
    List<PlayType> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
