package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.SystemNoticeMapper;
import com.yy.guess.po.SystemNotice;
import com.yy.guess.service.SystemNoticeService;
import com.yy.fast4j.QueryCondition;

@Repository("systemNoticeService")
@Transactional
public class SystemNoticeServiceImpl implements SystemNoticeService {
    @Autowired
    private SystemNoticeMapper mapper;

    @Override
    public void add(SystemNotice obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(SystemNotice obj) {
        mapper.update(obj);
    }

    @Override
    public SystemNotice find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public SystemNotice findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<SystemNotice> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public void setTop(int systemNoticeId) {
		Integer maxTop = mapper.getMaxTop();
		mapper.setTop(maxTop == null ? 1 : maxTop + 1, systemNoticeId);
	}
}
