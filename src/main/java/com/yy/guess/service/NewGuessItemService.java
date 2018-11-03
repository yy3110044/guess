package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.NewGuessItem;
import com.yy.fast4j.QueryCondition;

public interface NewGuessItemService {
    void add(NewGuessItem obj);
    void delete(int id);
    void update(NewGuessItem obj);
    NewGuessItem find(QueryCondition qc);
    NewGuessItem findById(int id);
    List<NewGuessItem> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
