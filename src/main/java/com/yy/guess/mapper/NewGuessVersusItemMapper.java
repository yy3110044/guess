package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.fast4j.QueryCondition;

@Mapper
public interface NewGuessVersusItemMapper {
    void add(NewGuessVersusItem obj);
    void delete(int id);
    void update(NewGuessVersusItem obj);
    NewGuessVersusItem find(QueryCondition qc);
    NewGuessVersusItem findById(int id);
    List<NewGuessVersusItem> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
