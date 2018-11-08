package com.yy.guess.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
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
    List<NewGuessVersus> getAllUnEndVersus(); //返回所有未结束的versus;
    
    @Update("update new_guess_versus set name = #{name}, returnRate = #{returnRate}, betAmountMin = #{betAmountMin}, betAmountMax = #{betAmountMax}, startTime = #{startTime} where id = #{versusId}")
    void updateVersus(String name, double returnRate, double betAmountMin, double betAmountMax, Date startTime, int versusId);
    
    @Update("update new_guess_versus set childVersusCount = childVersusCount + #{count} where id = #{versusId}")
    void plusChildVersusCount(int count, int versusId);//增加下级对阵数
    
    @Update("update new_guess_versus set status = #{status}, betPause = #{betPause} where id = #{versusId}")
    void updateStatusAndBetPause(NewGuessVersusStatus status, boolean betPause, int versusId);
    
    @Update("update new_guess_versus set betPause = #{betPause} where id = #{versusId}")
    void updateBetPause(boolean betPause, int versusId);
    
    @Delete("delete from new_guess_versus where superVersusId = #{superVersusId}")
    void deleteBySuperVersusId(int superVersusId);
    
    @Select("select name from new_guess_versus where id = #{versusId}")
    String getVersusNameByVersusId(int versusId);
    
    @Update("update new_guess_versus set endTime = #{endTime}, betPause = #{betPause}, resultItemId = #{resultItemId}, resultItemName = #{resultItemName}, status = #{status} where id = #{versusId}")
    void updateVersusResult(Date endTime, boolean betPause, int resultItemId, String resultItemName, NewGuessVersusStatus status, int versusId);
}