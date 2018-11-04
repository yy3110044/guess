package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.fast4j.QueryCondition;

public interface NewGuessVersusService {
    void add(NewGuessVersus obj);
    void delete(int id);
    void update(NewGuessVersus obj);
    NewGuessVersus find(QueryCondition qc);
    NewGuessVersus findById(int id);
    List<NewGuessVersus> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    void addVersus(NewGuessVersus versus, List<NewGuessVersusItem> versusItemList);
    void checkStart(NewGuessVersus versus);
}
