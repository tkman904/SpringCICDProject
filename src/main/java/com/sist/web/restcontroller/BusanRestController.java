package com.sist.web.restcontroller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

import com.sist.web.vo.*;
import com.sist.web.service.*;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class BusanRestController {
	private final BusanService bService;
	
	@GetMapping("/busan/list_vue/")
	public ResponseEntity<Map> busan_list(@RequestParam("type") int type, @RequestParam("page") int page) {
		Map map = new HashMap();
		try {
			map.put("type", type);
			map.put("start", (page-1)*6);
			
			List<BusanVO> list = bService.busanListData(map);
			int totalpage = bService.busanTotalPage(map);
			
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
