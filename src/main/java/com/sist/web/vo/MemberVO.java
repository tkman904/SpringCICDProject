package com.sist.web.vo;

import lombok.Data;

/*
    ID      NOT NULL VARCHAR2(20)  
	NAME    NOT NULL VARCHAR2(50)  
	SEX     NOT NULL VARCHAR2(10)  
	ADDRESS          VARCHAR2(200) 
	PWD     NOT NULL VARCHAR2(10)
 */

@Data
public class MemberVO {
	private String id, name, sex, address, pwd, msg;
}
