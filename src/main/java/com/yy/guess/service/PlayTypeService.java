package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.PlayType;
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
    
    void addList(List<PlayType> ptList, int versusId);
    void updateFixedOdds(boolean fixedOdds, double leftOdds, double rightOdds, int playTypeId);
}
