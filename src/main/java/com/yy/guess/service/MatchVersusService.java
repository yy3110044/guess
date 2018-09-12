package com.yy.guess.service;

import java.util.Date;
import java.util.List;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
import com.yy.guess.po.enums.MatchStatus;
import com.yy.guess.util.QueryResult;
import com.yy.fast4j.Page;
import com.yy.fast4j.QueryCondition;

public interface MatchVersusService {
    void add(MatchVersus obj);
    void delete(int id);
    void update(MatchVersus obj);
    MatchVersus find(QueryCondition qc);
    MatchVersus findById(int id);
    List<MatchVersus> query(QueryCondition qc);
    int getCount(QueryCondition qc);
    /*****************************************************************分隔线************************************************************************/
    
    void add(MatchVersus obj, List<MatchVersusBo> boList);
    void deleteVersus(int id);
    List<String> getDistinctName(int matchId);
    void update(MatchVersus obj, List<MatchVersusBo> boList);
    
    //status > 0：已结束、未比赛   status < 0：未开始、进行中   status = 0：全部
    QueryResult<MatchVersus> queryInSportId(List<Integer> sportIdList, int status, Date startTime, Date endTime, Page page);

    void updateStatus(MatchStatus status, int versusId);
    void updateAutoSwitchStatus(boolean autoSwitchStatus, int versusId);
}