package com.yy.guess.controller.administration;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.yy.fast4j.Fast4jUtils;
import com.yy.fast4j.JsonResultMap;
import com.yy.fast4j.RedisUtil;
import com.yy.fast4j.ResponseObject;
import com.yy.guess.po.PlayType;
import com.yy.guess.service.PlayTypeService;
import com.yy.guess.util.CachePre;

/**
 * 缓存查看，便于调试
 * @author 49803
 *
 */
@CrossOrigin
@RestController
@RequestMapping(value="administration", method=RequestMethod.POST)
public class CacheViewController {
	@Autowired
	private PlayTypeService pts;
	
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;
	
	@RequestMapping("/equals")
	public ResponseObject equals(@RequestParam int playTypeId) {
		PlayType dbPt = pts.findById(playTypeId);
		PlayType cachePt = pts.getStartPlayTypeByMap(playTypeId);
		return new ResponseObject(100, "返回成功", dbPt.equals(cachePt));
	}
	
	@RequestMapping("/getAllCachePlayType")
	public ResponseObject getAllCachePlayType(Integer playTypeId, Integer versusId) {
		List<PlayType> allPlayTypeList = pts.getAllCachePlayType();
		List<PlayType> resultList = new ArrayList<PlayType>();
		if(playTypeId != null) {
			PlayType pt = pts.getStartPlayTypeByMap(playTypeId);
			if(pt != null) {
				resultList.add(pt);
			}
		} else {
			if(versusId != null) {
				for(PlayType pt : allPlayTypeList) {
					if(pt.getVersusId() == versusId) {
						resultList.add(pt);
					}
				}
			} else {
				resultList = allPlayTypeList;
			}
		}
		Collections.sort(resultList, new PlayTypeComparator());

		JsonResultMap[] maps = new JsonResultMap[resultList.size()];
		for(int i=0; i<resultList.size(); i++) {
			PlayType pt = resultList.get(i);
			maps[i] = Fast4jUtils.objectToMap(pt);
			maps[i].put("redisLeftBonusPool", RedisUtil.getDouble(redisTemplate, CachePre.GUESS_LEFT_BONUS_POOL, String.valueOf(pt.getId())));
			maps[i].put("redisRightBonusPool", RedisUtil.getDouble(redisTemplate, CachePre.GUESS_RIGHT_BONUS_POOL, String.valueOf(pt.getId())));
		}
		
		JsonResultMap resultMap = new JsonResultMap();
		resultMap.put("list", maps);
		resultMap.put("totalCount", allPlayTypeList.size());
		return new ResponseObject(100, "返回成功", resultMap);
	}
	
	private class PlayTypeComparator implements Comparator<PlayType> {
		@Override
		public int compare(PlayType pt1, PlayType pt2) {
			if(pt1.getVersusId() > pt2.getVersusId()) {
				if(pt1.getBo() > pt2.getBo()) {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				} else if(pt1.getBo() < pt2.getBo()) {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				} else {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				}
			} else if(pt1.getVersusId() < pt2.getVersusId()) {
				if(pt1.getBo() > pt2.getBo()) {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				} else if(pt1.getBo() < pt2.getBo()) {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				} else {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				}
			} else {
				if(pt1.getBo() > pt2.getBo()) {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				} else if(pt1.getBo() < pt2.getBo()) {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				} else {
					if(pt1.getId() > pt2.getId()) {
						return 1;
					} else if(pt1.getId() < pt2.getId()) {
						return -1;
					} else {
						return 0;
					}
				}
			}
		}
	}
}