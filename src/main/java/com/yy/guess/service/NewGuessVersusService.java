package com.yy.guess.service;

import java.util.Date;
import java.util.List;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.util.QueryResult;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;
import com.yy.fast4j.ResponseObject;

public interface NewGuessVersusService {
    NewGuessVersus find(QueryCondition qc);
    NewGuessVersus findById(int id);
    List<NewGuessVersus> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    QueryResult<NewGuessVersus> queryInItemId(List<Integer> itemIdList, int status, Date startTimeStart, Date startTimeEnd, Page page);
    
    void update(String name, double returnRate, double betAmountMin, double betAmountMax, Date startTime, int leftTeamScore, int rightTeamScore, boolean showTeamScore, int versusId); //修改versus
    
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
    
    //从数据库中获取versus、versusItem、以以计算赔率
    JsonResultMap getVersusAndVersusItemAndOddsToDatabase(int versusItemId);
    
    //计算赔率
    double getOdds(int versusItemId);
    
    //根据versusId取得versusName
    String getVersusNameByVersusId(int versusId);
    String[] getVersusNamesByVersusIds(int[] versusIds);
    JsonResultMap[] getVersusNamesByVersusIdsReturnMap(int[] versusIds);
    
    //更改结果
    ResponseObject updateResult(int resultItemId, int versusId);
    
    //重置竞猜
    void reset(int versusId);
    
    List<NewGuessVersus> queryInIds(List<Integer> idList);
}
