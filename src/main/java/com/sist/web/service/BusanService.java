package com.sist.web.service;

import java.util.*;

import com.sist.web.vo.*;

public interface BusanService {
	public List<BusanVO> busanListData(Map map);
	public int busanTotalPage(Map map);
}
