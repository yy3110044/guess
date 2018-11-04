package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.enums.NewGuessVersusStatus;
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
    @Update("update new_guess_versus set childVersusCount = childVersusCount + #{count} where id = #{versusId}")
    void plusChildVersusCount(int count, int versusId);//增加下级对阵数
    
    @Update("update new_guess_versus set status = #{status}, betPause = #{betPause} where id = #{versusId}")
    void updateStatusAndBetPause(NewGuessVersusStatus status, boolean betPause, int versusId);
    
    @Update("update new_guess_versus set betPause = #{betPause} where id = #{versusId}")
    void updateBetPause(boolean betPause, int versusId);
}
