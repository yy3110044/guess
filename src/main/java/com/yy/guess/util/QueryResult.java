package com.yy.guess.util;

import java.util.List;
import com.yy.fast4j.Page;

public class QueryResult <T> {
	private List<T> list;
	private Page page;
	public QueryResult(List<T> list, Page page) {
		this.list = list;
		this.page = page;
	}
	public List<T> getList() {
		return list;
	}
	public void setList(List<T> list) {
		this.list = list;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
}