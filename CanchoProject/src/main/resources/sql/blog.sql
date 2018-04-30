-- blog_user table
CREATE TABLE blog_user
(
    user_id          VARCHAR2(45)     primary key, 
    user_name        VARCHAR2(45)     NOT NULL, 
    user_email       VARCHAR2(100)    NOT NULL unique, 
    user_password    VARCHAR2(100)    NOT NULL,
    user_verify		 VARCHAR2(50)	  default 'N',
    user_deleted	 VARCHAR2(50)	  default 'N'
);

-- blog_post table
CREATE TABLE blog_post
(
    post_num            INT              NOT NULL, 
    post_title          VARCHAR2(144)    NOT NULL, 
    post_title_clean    VARCHAR2(10)     NULL, 
    post_file           VARCHAR2(300)    NOT NULL, 
    user_id             VARCHAR2(45)     NOT NULL, 
    originalfile		VARCHAR2(200),
	savedfile			VARCHAR2(100),
    post_date           DATE             default SYSDATE,
    post_like			INT 			 default 0,
    post_dislike		INT   			 default 0,
    CONSTRAINT BLOG_POST_PK PRIMARY KEY (post_num),
    CONSTRAINT FK_blog_post_user_id_blog_u FOREIGN KEY (user_id)
    REFERENCES blog_user (user_id)
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
    CONSTRAINT FK_blog_friend_user_id FOREIGN KEY (user_id) REFERENCES blog_user (user_id),
	CONSTRAINT FK_blog_friend_friend_ FOREIGN KEY (friend_id) REFERENCES blog_user (user_id)
);

-- blog_comment table
CREATE TABLE blog_comment
(
    comment_num     INT              NOT NULL, 
    post_num        INT              NOT NULL, 
    comment_text    VARCHAR2(300)    NOT NULL, 
    user_id         VARCHAR2(45)     NOT NULL, 
    comment_date    DATE             NOT NULL, 
    CONSTRAINT BLOG_COMMENT_PK PRIMARY KEY (comment_num)
    ,CONSTRAINT FK_blog_comment_post_num_blog_ FOREIGN KEY (post_num)
    REFERENCES blog_post (post_num)
    ,CONSTRAINT FK_blog_comment_user_id_blog_u FOREIGN KEY (user_id)
    REFERENCES blog_user (user_id)
);

-- blog_comment sequence
CREATE SEQUENCE blog_comment_SEQ
START WITH 1
INCREMENT BY 1;

-- blog_profile table
CREATE TABLE blog_profile
(
    user_id		varchar2(45),
    user_email       VARCHAR2(100),
    p_birthDate   	varchar2(40) not null,
    p_sex		varchar2(20) not null,
    p_city      varchar2(100) not null,
    p_country   varchar2(100) not null,
    p_company   varchar2(100) default '-',
    p_school	varchar2(100) default '-',
    p_introduce     varchar2(1000) default '-',
    p_originalfile		VARCHAR2(200),
	p_savedfile			VARCHAR2(100),
	constraint user_id_fk foreign key(user_id) references blog_user(user_id),
	constraint user_email_fk foreign key(user_email) references blog_user(user_email)
);