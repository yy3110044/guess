package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.Config;
import com.yy.fast4j.QueryCondition;

public interface ConfigService {
    void add(Config obj);
    void delete(int id);
    void update(Config obj);
    Config find(QueryCondition qc);
    Config findById(int id);
    List<Config> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    void update(Config[] configs);//批量修改
}
