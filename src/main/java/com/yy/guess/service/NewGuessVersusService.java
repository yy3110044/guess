package com.yy.guess.service;

import java.util.Date;
import java.util.List;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.QueryCondition;

public interface NewGuessVersusService {
    NewGuessVersus find(QueryCondition qc);
    NewGuessVersus findById(int id);
    List<NewGuessVersus> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    void update(String name, double returnRate, double betAmountMin, double betAmountMax, Date startTime, int versusId); //修改versus
    
    void initCacheMap(); //初始化缓存map
    
    void addVersus(NewGuessVersus versus, List<NewGuessVersusItem> versusItemList);//添加versus
    void deleteVersus(int versusId); //删除一个versus，以及他的所有子竞猜

    void checkStart(NewGuessVersus versus);//检查是否到了开始时间，如果到了，就开启竞猜
    void cleanCache(int versusId);//清除缓存
    
    void updateBetPause(boolean betPause, int versusId); //更新暂停状态
    
    NewGuessVersus getVersusCache(int versusId); //从redis缓存中获取versus，缓存中没有返回null;
    List<NewGuessVersusItem> getVersusItemCacheByVersusId(int versusId); //从redis缓存中获取versusItemList
    NewGuessVersusItem getVersusItemCache(int versusItemId); //从redis缓存中获取versusItem
    
    //从缓存中获取versusItem状态：odds(赔率)、pause(暂停)
    JsonResultMap getVersusItemStatusToCache(int versusItemId);
    JsonResultMap getVersusItemStatusToCache(int[] versusItemIds);
    JsonResultMap[] getVersusItemStatusToCacheReturnArray(int[] versusItemIds);
    
    //从数据库中获取versusItem状态：odds(赔率)、pause(暂停)
    JsonResultMap getVersusItemStatusToDatabase(int versusItemId);
    JsonResultMap getVersusItemStatusToDatabase(int[] versusItemIds);
    JsonResultMap[] getVersusItemStatusToDatabaseReturnArray(int[] versusItemIds);
}
