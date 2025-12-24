package com.sist.web.restcontroller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

import com.sist.web.service.*;
import com.sist.web.vo.*;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class SeoulRestController {
	private final SeoulService sService;
	
	private String[] tables = {"", "seoul_location", "seoul_nature", "seoul_shop"};
	
	@GetMapping("/seoul/list_vue/")
	public ResponseEntity<Map> seoul_list(@RequestParam("page") int page, @RequestParam("type") int type) {
		Map map = new HashMap();
		
		try {
			map.put("table_name", tables[type]);
			map.put("start", (page-1)*6);
			
			List<SeoulVO> list = sService.seoulListData(map);
			int totalpage = sService.seoulTotalPage(map);
			
			final int BLOCK = 10;
			int startPage = ((page-1)/BLOCK*BLOCK)+1;
			int endPage = ((page-1)/BLOCK*BLOCK)+BLOCK;
			if(endPage>totalpage) {
				endPage = totalpage;
			}
			
			// 출력에 필요한 데이터를 Vue로 전송
			map = new HashMap();
			
			map.put("list", list);
			map.put("curpage", page);
			map.put("totalpage", totalpage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("type", type);
		} catch(Exception ex) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map, HttpStatus.OK);
	}	
}
