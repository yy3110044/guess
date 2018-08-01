package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.Config;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface ConfigMapper {
    void add(Config obj);
    void delete(int id);
    void update(Config obj);
    Config find(QueryCondition qc);
    Config findById(int id);
    List<Config> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
