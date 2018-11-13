package com.yy.guess.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.yy.guess.mapper.NewGuessVersusItemMapper;
import com.yy.guess.po.NewGuessVersusItem;
import com.yy.guess.service.NewGuessVersusItemService;
import com.yy.guess.util.CachePre;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.QueryCondition;

@Repository("newGuessVersusItemService")
@Transactional
public class NewGuessVersusItemServiceImpl implements NewGuessVersusItemService {
    @Autowired
    private NewGuessVersusItemMapper mapper;

    @Override
    public NewGuessVersusItem find(QueryCondition qc) {
        return mapper.find(qc);
    }

    @Override
    public NewGuessVersusItem findById(int id) {
        return mapper.findById(id);
    }

    @Override
    public List<NewGuessVersusItem> query(QueryCondition qc) {
        return mapper.query(qc);
    }

    @Override
    public int getCount(QueryCondition qc) {
        return mapper.getCount(qc);
    }
    /*****************************************************************分隔线************************************************************************/

    @Override
	public void delete(int versusItemId) {
		mapper.delete(versusItemId); //删除数据库
		CachePre.versusItemMap.remove(versusItemId); //删除缓存
	}
    
	@Override
	public void update(NewGuessVersusItem versusItem) {
		mapper.update(versusItem);
		if(CachePre.versusItemMap.containsKey(versusItem.getId())) {
			CachePre.versusItemMap.put(versusItem.getId(), mapper.findById(versusItem.getId()));//更改缓存
		}
	}

	@Override
	public List<Integer> getVersusItemIdList(int versusId) {
		return mapper.getVersusItemIdList(versusId);
	}

	@Override
	public void update(List<NewGuessVersusItem> versusItemList) {
		for(NewGuessVersusItem versusItem : versusItemList) {
			this.update(versusItem);
		}
	}

	@Override
	public String getVersusItemNameByVersusItemId(int versusItemId) {
		return mapper.getVersusItemNameByVersusItemId(versusItemId);
	}

	@Override
	public String[] getVersusItemNamesByVersusItemIds(int[] versusItemIds) {
		String[] result = new String[versusItemIds.length];
		for(int i=0; i<versusItemIds.length; i++) {
			result[i] = mapper.getVersusItemNameByVersusItemId(versusItemIds[i]);
		}
		return result;
	}

	@Override
	public JsonResultMap[] getVersusItemNamesByVersusItemIdsReturnMap(int[] versusItemIds) {
		JsonResultMap[] result = new JsonResultMap[versusItemIds.length];
		for(int i=0; i<versusItemIds.length; i++) {
			result[i] = new JsonResultMap();
			result[i].put(String.valueOf(versusItemIds[i]), mapper.getVersusItemNameByVersusItemId(versusItemIds[i]));
		}
		return result;
	}

	@Override
	public List<NewGuessVersusItem> queryInIds(List<Integer> idList) {
		return mapper.queryInIds(idList);
	}
}
