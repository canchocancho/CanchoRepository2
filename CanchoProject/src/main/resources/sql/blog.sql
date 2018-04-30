-- blog_user table
CREATE TABLE blog_user
(
    user_id          VARCHAR2(45)     PRIMARY KEY, 
    user_name        VARCHAR2(45)     NOT NULL, 
    user_email       VARCHAR2(100)    NOT NULL unique, 
    user_password    VARCHAR2(100)    NOT NULL,
    user_verify		 VARCHAR2(50)	  default 'N',
    user_deleted	 VARCHAR2(50)	  default 'N'
);

-- blog_post table
CREATE TABLE blog_post
(
    post_num            INT              PRIMARY KEY, 
    post_title          VARCHAR2(144)    NOT NULL, 
    post_title_clean    VARCHAR2(10)     NULL, 
    post_file           VARCHAR2(300)    NOT NULL, 
    user_id             VARCHAR2(45)     NOT NULL, 
    originalfile		VARCHAR2(200),
	savedfile			VARCHAR2(100),
    post_date           DATE             default SYSDATE,
    post_like			INT 			 default 0,
    post_dislike		INT   			 default 0,
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES blog_user (user_id)
);

-- blog_post sequence
CREATE SEQUENCE blog_post_seq
START WITH 1
INCREMENT BY 1;

-- blog_friend table
CREATE TABLE blog_friend
(
    user_id      VARCHAR2(45)    NOT NULL, 
    friend_id    VARCHAR2(45)    NOT NULL,
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES blog_user (user_id),
	CONSTRAINT FOREIGN KEY (friend_id) REFERENCES blog_user (user_id)
);

-- blog_comment table
CREATE TABLE blog_comment
(
    comment_num     INT              PRIMARY KEY, 
    post_num        INT              NOT NULL, 
    comment_text    VARCHAR2(300)    NOT NULL, 
    user_id         VARCHAR2(45)     NOT NULL, 
    comment_date    DATE             NOT NULL, 
	CONSTRAINT FOREIGN KEY (post_num) REFERENCES blog_post (post_num),
    CONSTRAINT FOREIGN KEY (user_id) REFERENCES blog_user (user_id)
);

-- blog_comment sequence
CREATE SEQUENCE blog_comment_SEQ
START WITH 1
INCREMENT BY 1;

-- blog_profile table
CREATE TABLE blog_profile
(
    user_id				VARCHAR2(45),
    user_email       	VARCHAR2(100),
    p_birthDate   		VARCHAR2(40) NOT NULL,
    p_sex				VARCHAR2(20) NOT NULL,
    p_city     			VARCHAR2(100) NOT NULL,
    p_country  			VARCHAR2(100) NOT NULL,
    p_company   		VARCHAR2(100),
    p_school			VARCHAR2(100),
    p_introduce    		VARCHAR2(1000),
    p_originalfile		VARCHAR2(200),
	p_savedfile			VARCHAR2(100),
	CONSTRAINT FOREIGN KEY (user_id) REFERENCES blog_user (user_id),
	CONSTRAINT FOREIGN KEY (user_email) REFERENCES blog_user (user_email)
);