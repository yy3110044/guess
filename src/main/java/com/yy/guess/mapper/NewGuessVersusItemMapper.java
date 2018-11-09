package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
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
    
    @Delete("delete from new_guess_versus_item where versusId = #{versusId}")
    void deleteByVersusId(int versusId);
    
    @Select("select id from new_guess_versus_item where versusId = #{versusId}")
    List<Integer> getVersusItemIdList(int versusId);//返回竞猜下，的所有竞猜项idList
    
    @Select("select name from new_guess_versus_item where id = #{versusItemId}")
    String getVersusItemNameByVersusItemId(int versusItemId);
    
    @Update("update new_guess_versus_item set allPayBonus = allPayBonus + #{allPayBonus} where id = #{versusItemId}")
    void plusAllPayBonus(double allPayBonus, int versusItemId);
    
    @Update("update new_guess_versus_item set betAmount = 0, allPayBonus = 0 where versusId = #{versusId}")
    void reset(int versusId);
}