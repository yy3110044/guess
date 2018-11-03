package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.NewGuessVersus;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface NewGuessVersusMapper {
    void add(NewGuessVersus obj);
    void delete(int id);
    void update(NewGuessVersus obj);
    NewGuessVersus find(QueryCondition qc);
    NewGuessVersus findById(int id);
    List<NewGuessVersus> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
