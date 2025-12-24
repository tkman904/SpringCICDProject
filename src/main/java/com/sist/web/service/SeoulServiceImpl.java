package com.sist.web.service;

import java.util.*;

import org.springframework.stereotype.Service;

import com.sist.web.mapper.*;
import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SeoulServiceImpl implements SeoulService {
	private final SeoulMapper mapper;
	private final FoodMapper fMapper;

	@Override
	public List<SeoulVO> seoulListData(Map map) {
		// TODO Auto-generated method stub
		return mapper.seoulListData(map);
	}

	@Override
	public int seoulTotalPage(Map map) {
		// TODO Auto-generated method stub
		return mapper.seoulTotalPage(map);
	}

	@Override
	public SeoulVO seoulDetailData(Map map) {
		// TODO Auto-generated method stub
		mapper.seoulHitIncrement(map);
		return mapper.seoulDetailData(map);
	}

	@Override
	public List<FoodVO> foodNearData4(String address) {
		// TODO Auto-generated method stub
		return fMapper.foodNearData4(address);
	}
}
