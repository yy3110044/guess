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

    void initCacheMap(); //初始化缓存map
    
    void addVersus(NewGuessVersus versus, List<NewGuessVersusItem> versusItemList);//添加versus
    void deleteVersus(int versusId); //删除一个versus，以及他的所有子竞猜

    void checkStart(NewGuessVersus versus);//检查是否到了开始时间，如果到了，就开启竞猜
    void cleanCache(int versusId);//清除缓存
    
    void updateBetPause(boolean betPause, int versusId); //更新暂停状态
    
    NewGuessVersus getVersusCache(int versusId); //从redis缓存中获取versus，缓存中没有返回null;
    List<NewGuessVersusItem> getVersusItemCacheByVersusId(int versusId); //从redis缓存中获取versusItemList
    NewGuessVersusItem getVersusItemCache(int versusItemId); //从redis缓存中获取versusItem
}
