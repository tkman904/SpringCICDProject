package com.sist.web.service;

import java.util.*;

import com.sist.web.vo.*;

public interface ReplyService {
	public List<ReplyVO> replyListData(int cno, int type);
	public void replyInsert(ReplyVO vo);
}
