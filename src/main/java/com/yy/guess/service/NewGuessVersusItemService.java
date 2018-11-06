package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.fast4j.QueryCondition;

public interface NewGuessVersusItemService {
    NewGuessVersusItem find(QueryCondition qc);
    NewGuessVersusItem findById(int id);
    List<NewGuessVersusItem> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
}
