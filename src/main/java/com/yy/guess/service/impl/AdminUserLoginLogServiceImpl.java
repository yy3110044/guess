package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.AdminUserLoginLogMapper;
import com.yy.guess.mapper.AdminUserMapper;
import com.yy.guess.po.AdminUser;
import com.yy.guess.po.AdminUserLoginLog;
import com.yy.guess.service.AdminUserLoginLogService;
import com.yy.fast4j.QueryCondition;

@Repository("adminUserLoginLogService")
@Transactional
public class AdminUserLoginLogServiceImpl implements AdminUserLoginLogService {
    @Autowired
    private AdminUserLoginLogMapper mapper;
    
    @Autowired
    private AdminUserMapper aum;

    @Override
    public void add(AdminUserLoginLog obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(AdminUserLoginLog obj) {
        mapper.update(obj);
    }

    @Override
    public AdminUserLoginLog find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public AdminUserLoginLog findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<AdminUserLoginLog> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public void addLog(AdminUserLoginLog log) {
		AdminUser au = aum.findById(log.getAdminUserId());
		au.setLastLoginIp(log.getLoginIp());
		au.setLastLoginTime(log.getLoginTime());
		aum.update(au);
		mapper.add(log);
	}
}
