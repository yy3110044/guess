package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.Bet;
import com.yy.guess.po.enums.BetDirection;
import com.yy.fast4j.QueryCondition;

public interface BetService {
    void add(Bet obj);
    void delete(int id);
    void update(Bet obj);
    Bet find(QueryCondition qc);
    Bet findById(int id);
    List<Bet> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    
    void loadStartedGuess(); //从数据库读取已开启的竞猜
    boolean startGuessByVersusId(int versusId); //开启对阵下的所有竞猜
    boolean stopGuessByVersusId(int versusId); //关闭对阵下的的有竞猜
    boolean startGuessByPlayTypeId(int playTypeId); //开启某个竞猜
    boolean stopGuessByPlayTypeId(int playTypeId); //关闭某个竞猜
    boolean checkGuessStarted(int playTypeId); //查看某个玩法是否已开启竞猜
    void cleanGuessCache(int playTypeId); //清除相关缓存
    double getOdds(int playTypeId, BetDirection betDirection);//返回赔率
    boolean bet(int playTypeId, int userId, String userName, BetDirection betDirection, double betAmount);//下注
    void settlement(Bet bet); //结算
}