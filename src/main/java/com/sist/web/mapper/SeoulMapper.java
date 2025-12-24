package com.sist.web.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.*;

import com.sist.web.vo.*;

@Mapper
@Repository
public interface SeoulMapper {
	/*
      <select id="seoulListData" resultType="com.sist.web.vo.SeoulVO" parameterType="hashmap">
	    SELECT no, title, poster, address, hit
	    FROM ${table_name}
	    ORDER BY no ASC
	    OFFSET #{start} ROWS FETCH NEXT 12 ROWS ONLY
	  </select>
	 */
	public List<SeoulVO> seoulListData(Map map);
	
	/*
	  <select id="seoulTotalPage" resultType="int" parameterType="hashmap">
	    SELECT CEIL(COUNT(*)/12.0)
	    FROM ${table_name}
	  </select>
	 */
	public int seoulTotalPage(Map map);
	// => 인터페이스는 서로 다른 클래스 연결 (리모콘)
}
