DROP TABLE ATTACHMENT;
DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE CATEGORY;
DROP TABLE NOTICE;
DROP TABLE MEMBER;

DROP SEQUENCE SEQ_UNO; -- 회원번호 발생시킬 시퀀스
DROP SEQUENCE SEQ_NNO; -- 공지사항번호 발생시킬 시퀀스
DROP SEQUENCE SEQ_BNO; -- 게시판번호 발생시킬 시퀀스
DROP SEQUENCE SEQ_RNO; -- 댓글번호 발생시킬 시퀀스
DROP SEQUENCE SEQ_FNO; -- 첨부파일번호 발생시킬 시퀀스

--------------------------------------------------------------------------
------------------------ MEMBER 관련 ---------------------------
--------------------------------------------------------------------

CREATE TABLE MEMBER(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(30) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(100) NOT NULL,
    USER_NAME VARCHAR2(15) NOT NULL,
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(100),
    ADDRESS VARCHAR2(100),
    INTEREST VARCHAR2(100),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    MODIFY_DATE DATE DEFAULT SYSDATE,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N'))
);

COMMENT ON COLUMN MEMBER.USER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.USER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.INTEREST IS '취미';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원가입일';
COMMENT ON COLUMN MEMBER.MODIFY_DATE IS '정보수정일';
COMMENT ON COLUMN MEMBER.STATUS IS '상태값(Y/N)';

CREATE SEQUENCE SEQ_UNO
NOCACHE;

INSERT INTO MEMBER
VALUES (SEQ_UNO.NEXTVAL, 'admin', '1234', '관리자', '010-1111-2222', 'admin@kh.or.kr', '서울시 강남구 역삼동', NULL, '2022-02-10', '2022-02-10', 'Y');

INSERT INTO MEMBER
VALUES (SEQ_UNO.NEXTVAL, 'user01', 'pass01', '홍길동', '010-3333-2222', 'user01@kh.or.kr', '서울시 양천구 목동', NULL, '2023-01-10', '2023-01-10', 'Y');

INSERT INTO MEMBER
VALUES (SEQ_UNO.NEXTVAL, 'user02', 'pass02', '김개똥', '010-5424-3333', 'user02@kh.or.kr', '서울시 강서구', NULL, '2023-03-08', '2023-03-08', 'Y');

--------------------------------------------------------------------------
------------------------ NOTICE 관련 ---------------------------
--------------------------------------------------------------------

CREATE TABLE NOTICE(
    NOTICE_NO NUMBER PRIMARY KEY,
    NOTICE_TITLE VARCHAR2(100) NOT NULL,
    NOTICE_CONTENT VARCHAR2(4000) NOT NULL,
    NOTICE_WRITER NUMBER NOT NULL,
    COUNT NUMBER DEFAULT 0,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y','N')),
    FOREIGN KEY(NOTICE_WRITER) REFERENCES MEMBER(USER_NO)
);

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '공지사항번호';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '공지사항제목';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '공지사항내용';
COMMENT ON COLUMN NOTICE.NOTICE_WRITER IS '작성자회원번호';
COMMENT ON COLUMN NOTICE.COUNT IS '조회수';
COMMENT ON COLUMN NOTICE.CREATE_DATE IS '작성일';
COMMENT ON COLUMN NOTICE.STATUS IS '상태값(Y/N)';

CREATE SEQUENCE SEQ_NNO
NOCACHE;

INSERT INTO NOTICE
VALUES (SEQ_NNO.NEXTVAL, '첫번째 공지사항입니다.', '첫번재 공지사항 내용입니다.', 1, DEFAULT, '2022-02-10', DEFAULT);

INSERT INTO NOTICE
VALUES (SEQ_NNO.NEXTVAL, '두번째 공지사항입니다.', '두번재 공지사항 내용입니다.', 1, DEFAULT, '2022-02-10', DEFAULT);

--------------------------------------------------------------------------
------------------------ CATEGORY 관련 (BOARD의 CID와 연관) ---------------------------
--------------------------------------------------------------------

CREATE TABLE CATEGORY(
    CATEGORY_NO NUMBER PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN CATEGORY.CATEGORY_NO IS '카테고리번호';
COMMENT ON COLUMN CATEGORY.CATEGORY_NAME IS '카테고리명';

INSERT INTO CATEGORY VALUES(10, '공통');
INSERT INTO CATEGORY VALUES(20, '운동');
INSERT INTO CATEGORY VALUES(30, '등산');
INSERT INTO CATEGORY VALUES(40, '게임');
INSERT INTO CATEGORY VALUES(50, '낚시');
INSERT INTO CATEGORY VALUES(60, '요리');
INSERT INTO CATEGORY VALUES(70, '기타');


--------------------------------------------------------------------------
------------------------ BOARD 관련 ---------------------------
--------------------------------------------------------------------

CREATE TABLE BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TYPE NUMBER, -- 일반 게시판(1) 사진게시판(2)
    CATEGORY_NO NUMBER,
    BOARD_TITLE VARCHAR2(100) NOT NULL,
    BOARD_CONTENT VARCHAR2(4000) NOT NULL,
    BOARD_WRITER NUMBER NOT NULL,
    COUNT NUMBER DEFAULT 0,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
    FOREIGN KEY (BOARD_WRITER) REFERENCES MEMBER(USER_NO),
    FOREIGN KEY (CATEGORY_NO) REFERENCES CATEGORY(CATEGORY_NO)
);

COMMENT ON COLUMN BOARD.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_TYPE IS '게시글타입(일반1/사진2)';
COMMENT ON COLUMN BOARD.CATEGORY_NO IS '카테고리번호';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '게시글내용';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '작성자회원번호';
COMMENT ON COLUMN BOARD.COUNT IS '조회수';
COMMENT ON COLUMN BOARD.CREATE_DATE IS '작성일';
COMMENT ON COLUMN BOARD.STATUS IS '상태값(Y/N)';

CREATE SEQUENCE SEQ_BNO
NOCACHE;

--------------------------------------------------------------------------
------------------------ REPLY 관련 ---------------------------
--------------------------------------------------------------------

CREATE TABLE REPLY(
    REPLY_NO NUMBER PRIMARY KEY,
    REPLY_CONTENT VARCHAR2(400) NOT NULL,
    REF_BNO NUMBER NOT NULL,
    REPLY_WRITER NUMBER NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y','N')),
    FOREIGN KEY (REF_BNO) REFERENCES BOARD(BOARD_NO),
    FOREIGN KEY (REPLY_WRITER) REFERENCES MEMBER(USER_NO)
);

COMMENT ON COLUMN REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN REPLY.REPLY_CONTENT IS '댓글내용';
COMMENT ON COLUMN REPLY.REF_BNO IS '참조하는게시글번호';
COMMENT ON COLUMN REPLY.REPLY_WRITER IS '작성자회원번호';
COMMENT ON COLUMN REPLY.CREATE_DATE IS '작성일';
COMMENT ON COLUMN REPLY.STATUS IS '상태값(Y/N)';

CREATE SEQUENCE SEQ_RNO
NOCACHE;

--------------------------------------------------------------------------
------------------------ ATTACHMENT 관련 ---------------------------
--------------------------------------------------------------------

CREATE TABLE ATTACHMENT(
    FILE_NO NUMBER PRIMARY KEY,
    REF_BNO NUMBER NOT NULL,
    ORIGIN_NAME VARCHAR2(255) NOT NULL,
    CHANGE_NAME VARCHAR2(255) NOT NULL,
    FILE_PATH VARCHAR2(1000),
    UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL,
    FILE_LEVEL NUMBER,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y','N')),
    FOREIGN KEY (REF_BNO) REFERENCES BOARD(BOARD_NO)
);

COMMENT ON COLUMN ATTACHMENT.FILE_NO IS '파일번호';
COMMENT ON COLUMN ATTACHMENT.REF_BNO IS '참조게시글번호';
COMMENT ON COLUMN ATTACHMENT.ORIGIN_NAME IS '파일원본명';
COMMENT ON COLUMN ATTACHMENT.CHANGE_NAME IS '파일수정명';
COMMENT ON COLUMN ATTACHMENT.FILE_PATH IS '저장폴더경로';
COMMENT ON COLUMN ATTACHMENT.UPLOAD_DATE IS '업로드일';
COMMENT ON COLUMN ATTACHMENT.FILE_LEVEL IS '파일레벨(1/2)';

CREATE SEQUENCE SEQ_FNO
NOCACHE;

COMMIT;
