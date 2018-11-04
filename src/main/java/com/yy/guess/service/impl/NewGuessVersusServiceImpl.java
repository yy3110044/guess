package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessVersusItemMapper;
import com.yy.guess.mapper.NewGuessVersusMapper;
import com.yy.guess.po.NewGuessVersus;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.po.enums.NewGuessVersusStatus;
import com.yy.guess.service.NewGuessVersusService;
import com.yy.fast4j.QueryCondition;

@Repository("newGuessVersusService")
@Transactional
public class NewGuessVersusServiceImpl implements NewGuessVersusService {
    @Autowired
    private NewGuessVersusMapper mapper;
    
    @Autowired
    private NewGuessVersusItemMapper ngvim; 

    @Override
    public void add(NewGuessVersus obj) {
        mapper.add(obj);
    }

    @Override
    public void delete(int id) {
        mapper.delete(id);
    }

    @Override
    public void update(NewGuessVersus obj) {
        mapper.update(obj);
    }

    @Override
    public NewGuessVersus find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public NewGuessVersus findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<NewGuessVersus> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

	@Override
	public void addVersus(NewGuessVersus versus, List<NewGuessVersusItem> versusItemList) {
		mapper.add(versus);
		if(versus.getSuperVersusId() > 0) {
			mapper.plusChildVersusCount(1, versus.getSuperVersusId());
		}
		for(NewGuessVersusItem versusItem : versusItemList) {
			versusItem.setVersusId(versus.getId());
		}
		ngvim.addList(versusItemList);
	}

	@Override
	public void checkStart(NewGuessVersus versus) {
		if(versus.getStartTime() != null) {
			long current = System.currentTimeMillis();
			if(versus.getStatus() == NewGuessVersusStatus.未开始 && current >= versus.getStartTime().getTime()) {
				mapper.updateStatusAndBetPause(NewGuessVersusStatus.进行中, false, versus.getId());
			}
		}
	}
}
