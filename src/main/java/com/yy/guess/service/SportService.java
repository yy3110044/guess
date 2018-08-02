package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.Sport;
import com.yy.fast4j.QueryCondition;

public interface SportService {
    void add(Sport obj);
    void delete(int id);
    void update(Sport obj);
    Sport find(QueryCondition qc);
    Sport findById(int id);
    List<Sport> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
