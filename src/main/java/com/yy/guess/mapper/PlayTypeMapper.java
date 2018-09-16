package com.yy.guess.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.enums.MatchStatus;
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
    void addList(@Param("ptList") List<PlayType> ptList);

    //删除
    @Delete("delete from guess_play_type where versusId = #{versusId}")
    void deleteByVersusId(int versusId);
    @Delete("delete from guess_play_type where versusId = #{versusId} and bo = #{bo}")
    void deleteByVersusIdAndBo(int versusId, int bo);

    //更新开启状态
    @Update("update guess_play_type set guessStart = #{guessStart} where id = #{playTypeId}")
    void updateGuessStartByPlayTypeId(boolean guessStart, int playTypeId);
    @Update("update guess_play_type set guessStart = #{guessStart} where versusId = #{versusId}")
    void updateGuessStartByVersusId(boolean guessStart, int versusId);
    @Update("update guess_play_type set guessStart = #{guessStart} where versusId = #{versusId} and bo = #{bo}")
    void updateGuessStartByVersusIdAndBo(boolean guessStart, int versusId, int bo);
    
    
    //返回id
    @Select("select id from guess_play_type where versusId = #{versusId}")
    List<Integer> getPlayTypeIdListByVersusId(int versusId);
    @Select("select id from guess_play_type where versusId = #{versusId} and bo = #{bo}")
    List<Integer> getPlayTypeIdListByVersusIdAndBo(int versusId, int bo);
    
    
    //更新预计胜率以及固定赔率开关
    @Update("update guess_play_type set leftWinRate = #{leftWinRate}, rightWinRate = #{rightWinRate} where id = #{playTypeId}")
    void updateWinRate(double leftWinRate, double rightWinRate, int playTypeId);
    @Update("update guess_play_type set fixedOdds = #{fixedOdds} where id = #{playTypeId}")
    void updateFixedOdds(boolean fixedOdds, int playTypeId);
    @Update("update guess_play_type set leftWinRate = #{leftWinRate}, rightWinRate = #{rightWinRate}, fixedOdds = #{fixedOdds} where id = #{playTypeId}")
    void updateWinRateAndFixedOdds(double leftWinRate, double rightWinRate, boolean fixedOdds, int playTypeId);
    @Update("update guess_play_type set leftWinRate = #{leftWinRate}, rightWinRate = #{rightWinRate} where versusId = #{versusId}")
    void updateWinRateByVersusId(double leftWinRate, double rightWinRate, int versusId);
    @Update("update guess_play_type set fixedOdds = #{fixedOdds} where versusId = #{versusId}")
    void updateFixedOddsByVersusId(boolean fixedOdds, int versusId);
    @Update("update guess_play_type set leftWinRate = #{leftWinRate}, rightWinRate = #{rightWinRate}, fixedOdds = #{fixedOdds} where versusId = #{versusId}")
    void updateWinRateAndFixedOddsByVersusId(double leftWinRate, double rightWinRate, boolean fixedOdds, int versusId);
    @Update("update guess_play_type set leftWinRate = #{leftWinRate}, rightWinRate = #{rightWinRate} where versusId = #{versusId} and bo = #{bo}")
    void updateWinRateByVersusIdAndBo(double leftWinRate, double rightWinRate, int versusId, int bo);
    @Update("update guess_play_type set fixedOdds = #{fixedOdds} where versusId = #{versusId} and bo = #{bo}")
    void updateFixedOddsByVersusIdAndBo(boolean fixedOdds, int versusId, int bo);
    @Update("update guess_play_type set leftWinRate = #{leftWinRate}, rightWinRate = #{rightWinRate}, fixedOdds = #{fixedOdds} where versusId = #{versusId} and bo = #{bo}")
    void updateWinRateAndFixedOddsByVersusIdAndBo(double leftWinRate, double rightWinRate, boolean fixedOdds, int versusId, int bo);
    
    //更新奖金池
    @Update("update guess_play_type set leftBonusPool = #{leftBonusPool}, rightBonusPool = #{rightBonusPool} where id = #{playTypeId}")
    void updateBonusPool(double leftBonusPool, double rightBonusPool, int playTypeId);
    
    //更新暂停状态
    @Update("update guess_play_type set pause = #{pause} where id = #{playTypeId}")
    void updatePause(boolean pause, int playTypeId);
    
    //更改名称
    @Update("update guess_play_type set name = #{name} where id = #{playTypeId}")
    void updateName(String name, int playTypeId);
    
    //更改双方竞猜名
    @Update("update guess_play_type set leftGuessName = #{leftGuessName}, rightGuessName = #{rightGuessName} where id = #{playTypeId}")
    void updateGuessName(String leftGuessName, String rightGuessName, int playTypeId);
    
    //更改playType的状态以及结果
    @Update("update guess_play_type set status = #{status}, result = #{result} where id = #{playTypeId}")
    void updateStatusAndResultByPlayTypeId(MatchStatus status, int result, int playTypeId);
}