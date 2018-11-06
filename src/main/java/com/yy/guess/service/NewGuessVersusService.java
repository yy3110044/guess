package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.fast4j.QueryCondition;

public interface NewGuessVersusService {
    NewGuessVersus find(QueryCondition qc);
    NewGuessVersus findById(int id);
    List<NewGuessVersus> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    void addVersus(NewGuessVersus versus, List<NewGuessVersusItem> versusItemList);
    void deleteVersus(int versusId); //删除一个versus，以及他的所有子竞猜

    void checkStart(NewGuessVersus versus);//检查是否到了开始时间，如果到了，就开启竞猜
    void cleanCache(int versusId);//清除缓存
    
    void reset(int versusId); //重置一个竞猜，(清除下注额，并将状态设为未开始，并且暂停下注设为false，清除结束时间，结果)
}
