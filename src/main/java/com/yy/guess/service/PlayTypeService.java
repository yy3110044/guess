package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.PlayType;
import com.yy.guess.po.enums.BetDirection;
import com.yy.fast4j.QueryCondition;

public interface PlayTypeService {
    void add(PlayType obj);
    void delete(int id);
    void update(PlayType obj);
    PlayType find(QueryCondition qc);
    PlayType findById(int id);
    List<PlayType> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    
    void loadStartedPlayTypeToMap(); //加载已开启的竞猜到hashmap
    void addList(List<PlayType> ptList, int versusId); //添加一个列表
    PlayType getStartPlayTypeByMap(int id); //从map中取出playType
    void deleteByVersusId(int versusId); //根据versusId删除
    void deleteByVersusIdAndBo(int versusId, int bo); //根据versusId以及bo删除
    void updateGuessStartByPlayTypeId(boolean guessStart, int playTypeId); //根据playTypeId更改开启状态
    void updateGuessStartByVersusId(boolean guessStart, int versusId); //根据versusId更改开启状态
    void updateGuessStartByVersusIdAndBo(boolean guessStart, int versusId, int bo);//根据versusId以及bo更改开启状态
    
    void updateWinRate(double leftWinRate, double rightWinRate, int playTypeId); //更新两方胜率
    void updateFixedOdds(boolean fixedOdds, int playTypeId); //更新是否使用固定赔率
    void updateWinRateAndFixedOdds(double leftWinRate, double rightWinRate, boolean fixedOdds, int playTypeId); //更新胜率以及是否使用固定赔率
    void updateWinRateByVersusId(double leftWinRate, double rightWinRate, int versusId);
    void updateFixedOddsByVersusId(boolean fixedOdds, int versusId);
    void updateWinRateAndFixedOddsByVersusId(double leftWinRate, double rightWinRate, boolean fixedOdds, int versusId);
    void updateWinRateByVersusIdAndBo(double leftWinRate, double rightWinRate, int versusId, int bo);
    void updateFixedOddsByVersusIdAndBo(boolean fixedOdds, int versusId, int bo);
    void updateWinRateAndFixedOddsByVersusIdAndBo(double leftWinRate, double rightWinRate, boolean fixedOdds, int versusId, int bo);
    
    double getOdds(BetDirection betDirection, int playTypeId); //返回玩法的赔率
    double[] getOdds(int playTypeId); //返回玩法的赔率
    void cleanPlayTypeCache(int playTypeId); //清除playType缓存
    
    void stopGuessByPlayTypeId(int playTypeId);//关闭竞猜，并把奖金池，总投注额归档
    void stopGuessByVersusId(int versusId);//关闭竞猜，并把奖金池，总投注额归档
    void stopGuessByVersusIdAndBo(int versusId, int bo);//关闭竞猜，并把奖金池，总投注额归档
    
    double getBonusPool(BetDirection betDirection, int playTypeId); //返回奖金池
    double[] getBonusPool(int playTypeId); //返回奖金池
    
    void plusBonusPool(double amount, BetDirection betDirection, int playTypeId); //增加到奖金池
    
    void updatePause(boolean pause, int playTypeId); //更改暂停状态
    
    List<PlayType> getFirstPlayTypeByVersusList(List<MatchVersus> versusList); //返回每个对阵下的第一个playType
    List<PlayType> getFirstPlayTypeByVersusIdList(List<Integer> versusIdList); //返回每个对阵下的第一个PlayType
    
    void updateName(String name, int playTypeId); //更改名称
    void updateGuessName(String leftGuessName, String rightGuessName, int playTypeId); //更改双方竞猜名
}