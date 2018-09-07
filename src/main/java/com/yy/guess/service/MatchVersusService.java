package com.yy.guess.service;

import java.util.Date;
import java.util.List;
import com.yy.guess.po.MatchVersus;
import com.yy.guess.po.MatchVersusBo;
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

    List<MatchVersus> queryInSportIdScroll(List<Integer> sportIdList, Date endTime, Date startTime, Page page);
    int queryInSportIdScrollCount(List<Integer> sportIdList, Date endTime, Date startTime);

    List<MatchVersus> queryInSportIdStartTime(List<Integer> sportIdList, Date startTime, Date endTime, Page page);
    int queryInSportIdStartTimeCount(List<Integer> sportIdList, Date startTime, Date endTime);
}
