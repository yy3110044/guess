package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

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
    void addList(@Param("versusItemList") List<NewGuessVersusItem> versusItemList);
    
    @Delete("delete from new_guess_versus_item where where versusId = #{versusId}")
    void deleteByVersusId(int versusId);
    
    @Update("update new_guess_versus_item set betAmount = 0 where versusId = #{versusId}")
    void resetByVersusId(int versusId);
}
