package com.yy.guess.service;

import java.util.List;
import com.yy.guess.po.SystemNotice;
import com.yy.fast4j.QueryCondition;

public interface SystemNoticeService {
    void add(SystemNotice obj);
    void delete(int id);
    void update(SystemNotice obj);
    SystemNotice find(QueryCondition qc);
    SystemNotice findById(int id);
    List<SystemNotice> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/

    void setTop(int systemNoticeId);//置顶某个通知
}
