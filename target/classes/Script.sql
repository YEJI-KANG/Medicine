
-- 전체손님db
CREATE SEQUENCE person_idx_seq;
CREATE TABLE person(
	idx NUMBER PRIMARY KEY,
	name VARCHAR2(200) NOT NULL,
	idnum1 VARCHAR2(50) NOT NULL,
	idnum2 VARCHAR2(50) NOT NULL,
	point NUMBER DEFAULT 100 NOT NULL,
	temp1 VARCHAR2(200) --병원방문 count
);

DROP TABLE person;
DROP SEQUENCE person_idx_seq;


-- 처방목록db
CREATE SEQUENCE prelist_idx_seq;
CREATE TABLE prelist(
	idx NUMBER PRIMARY KEY,
	personidx NUMBER NOT NULL,
	predate TIMESTAMP DEFAULT SYSDATE NOT NULL,
	hospital VARCHAR2(200) NOT NULL,
	price NUMBER NOT NULL,
	temp1 VARCHAR2(200)
);
DROP TABLE prelist;
DROP SEQUENCE prelist_idx_seq;

-- 약정보db
CREATE SEQUENCE drug_idx_seq;
CREATE TABLE drug(
	idx NUMBER PRIMARY KEY,
	listidx NUMBER NOT NULL,
	drugname VARCHAR2(255) NOT NULL,
	how VARCHAR2(255) NOT NULL,
	temp1 VARCHAR2(200)
);
DROP TABLE DRUG;
DROP SEQUENCE drug_idx_seq;


-- 회원손님db
CREATE SEQUENCE family_idx_seq;
CREATE TABLE family(
	idx NUMBER PRIMARY KEY,
	personidx NUMBER NOT NULL,
	id VARCHAR2(200) UNIQUE NOT NULL,
	password VARCHAR2(200) NOT NULL,
	phone VARCHAR2(50) NOT NULL,
	temp1 VARCHAR2(200) DEFAULT '1' NOT NULL --로그인가능1 탈퇴0
);
DROP TABLE family;
DROP SEQUENCE family_idx_seq;


-- 회원탈퇴db (Family db 복제+탈퇴날짜)
CREATE SEQUENCE withdrawal_idx_seq;
CREATE TABLE withdrawal(
	idx NUMBER PRIMARY KEY,
	wdate TIMESTAMP DEFAULT SYSDATE NOT NULL,
	fidx NUMBER UNIQUE NOT NULL,
	personidx NUMBER NOT NULL,
	password VARCHAR2(200) NOT NULL,
	phone VARCHAR2(50) NOT NULL,
	temp1 VARCHAR2(200)
);
DROP TABLE withdrawal;
DROP SEQUENCE withdrawal_idx_seq;





-- 질문db
CREATE SEQUENCE question_idx_seq;
CREATE TABLE question(
	idx NUMBER PRIMARY KEY,
	fidx NUMBER NOT NULL,
	qmemo VARCHAR2(255) NOT NULL,
	qdate TIMESTAMP DEFAULT SYSDATE NOT NULL,
	temp1 VARCHAR2(200)
);
DROP TABLE question;
DROP SEQUENCE question_idx_seq;



-- 답변db
CREATE SEQUENCE answer_idx_seq;
CREATE TABLE answer(
	idx NUMBER PRIMARY KEY,
	qidx NUMBER UNIQUE NOT NULL,
	amemo VARCHAR2(255) NOT NULL,
	adate TIMESTAMP DEFAULT SYSDATE NOT NULL,
	temp1 VARCHAR2(200)
);
DROP TABLE answer;
DROP SEQUENCE answer_idx_seq;


-- 공지사항db
CREATE SEQUENCE notice_idx_seq;
CREATE TABLE notice(
	idx NUMBER PRIMARY KEY,
	title VARCHAR2(255) NOT NULL,
	context VARCHAR2(255) NOT NULL,
	regdate TIMESTAMP DEFAULT SYSDATE NOT NULL,
	cnt NUMBER DEFAULT 0 NOT NULL,
	temp1 VARCHAR2(200)
);
DROP TABLE notice;
DROP SEQUENCE notice_idx_seq;



COMMIT;


-- FK
ALTER TABLE answer
ADD CONSTRAINT fk_answer FOREIGN KEY(qidx)
REFERENCES question(idx);

ALTER TABLE question
ADD CONSTRAINT fk_question FOREIGN KEY(fidx)
REFERENCES family(idx);

ALTER TABLE withdrawal
ADD CONSTRAINT fk1_withdrawal FOREIGN KEY(fidx)
REFERENCES family(idx);

ALTER TABLE withdrawal
ADD CONSTRAINT fk2_withdrawal FOREIGN KEY(personidx)
REFERENCES person(idx);

ALTER TABLE family
ADD CONSTRAINT fk_family FOREIGN KEY(personidx)
REFERENCES person(idx); --탈퇴회원값 넣어줘야함

ALTER TABLE prelist
ADD CONSTRAINT fk_prelist FOREIGN KEY(personidx)
REFERENCES person(idx);

ALTER TABLE drug
ADD CONSTRAINT fk_drug FOREIGN KEY(listidx)
REFERENCES prelist(idx);


--데이터

--관리자(필수)
insert into person(idx,name,idnum1,idnum2,point) 
VALUES (0,'탈퇴회원','000000','0000000',0);

insert into person(idx,name,idnum1,idnum2,point) 
VALUES (person_idx_seq.nextval,'관리자','000000','0000000',0);

insert into family(idx,personidx,id,password,phone,temp1) 
VALUES (family_idx_seq.nextval,1,'admin','1234','00000000000','1');
	


COMMIT;

