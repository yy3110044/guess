package com.yy.guess.mapper;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.fast4j.Page;
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
    
    List<NewGuessVersus> queryInIds(@Param("idList") List<Integer> idList);
    
    List<NewGuessVersus> queryInItemId(@Param("itemIdList") List<Integer> itemIdList,
    								   @Param("status") int status,
    								   @Param("startTimeStart") Date startTimeStart,
    								   @Param("startTimeEnd") Date startTimeEnd,
    								   @Param("page") Page page);
    int queryInItemIdCount(@Param("itemIdList") List<Integer> itemIdList,
    					   @Param("status") int status,
    					   @Param("startTimeStart") Date startTimeStart,
    					   @Param("startTimeEnd") Date startTimeEnd);
    
    @Update("update new_guess_versus set name = #{name}, returnRate = #{returnRate}, betAmountMin = #{betAmountMin}, betAmountMax = #{betAmountMax}, startTime = #{startTime}, leftTeamScore = #{leftTeamScore}, rightTeamScore = #{rightTeamScore}, showTeamScore = #{showTeamScore} where id = #{versusId}")
    void updateVersus(String name, double returnRate, double betAmountMin, double betAmountMax, Date startTime, int leftTeamScore, int rightTeamScore, boolean showTeamScore, int versusId);
    
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

    @Update("update new_guess_versus set allPayBonus = allPayBonus + #{allPayBonus} where id = #{versusId}")
    void plusAllPayBonus(double allPayBonus, int versusId);
    
    @Update("update new_guess_versus set betAllAmount = betAllAmount + #{betAllAmount} where id = #{versusId}")
    void plusBetAllAmount(double betAllAmount, int versusId);
    
    @Update("update new_guess_versus set betAllAmount = 0, allPayBonus = 0, endTime = null, betPause = 0, resultItemId = 0, resultItemName = null, status = '未开始' where id = #{versusId}")
    void reset(int versusId);
}