package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.QueryCondition;

public interface NewGuessVersusItemService {
    NewGuessVersusItem find(QueryCondition qc);
    NewGuessVersusItem findById(int id);
    List<NewGuessVersusItem> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    
    void update(NewGuessVersusItem versusItem);
    /*****************************************************************分隔线************************************************************************/
    List<Integer> getVersusItemIdList(int versusId);//返回竞猜下，的所有竞猜项idList
    void update(List<NewGuessVersusItem> versusItemList); //批量更新
    void delete(int versusItemId);//删除versusItem
    
    //根据versusItemId得到versusItemName
    String getVersusItemNameByVersusItemId(int versusItemId);
    String[] getVersusItemNamesByVersusItemIds(int[] versusItemIds);
    JsonResultMap[] getVersusItemNamesByVersusItemIdsReturnMap(int[] versusItemIds);
    
    List<NewGuessVersusItem> queryInIds(List<Integer> idList);
}
