CREATE TABLE IF NOT EXISTS admin(
	uid int,
    email varchar(255),
    fname varchar(255),
    lname varchar(255),
    passw varchar(255),
    gender varchar(255),
    age int,
    dob DATE,
    activitylog varchar(255),
    PRIMARY KEY (uid)
);
CREATE TABLE IF NOT EXISTS user(
	uid int,
    ac_type varchar(255),
    email varchar(255),
    fname varchar(255),
    lname varchar(255),
    gender varchar(255),
    age int,
    dob DATE,
    passw varchar(255),
    PRIMARY KEY (uid, ac_type)
);
CREATE TABLE IF NOT EXISTS student(
	uid int,
    email varchar(255),
    fname varchar(255),
    lname varchar(255),
    gender varchar(255),
    age int,
    dob DATE,
    passw varchar(255),
    gpa float,
    financialstanding varchar(255),
    PRIMARY KEY (uid)
);
CREATE TABLE IF NOT EXISTS lecturer_course_maintainer(
	uid int,
    email varchar(255),
    fname varchar(255),
    lname varchar(255),
    passw varchar(255),
    gender varchar(255),
    age int,
    dob DATE,
    dept varchar(255),
    roll varchar(255),
    course_list varchar(255),
    PRIMARY KEY(uid)
);
CREATE TABLE IF NOT EXISTS course(
	cid varchar(255),
    cname varchar(255),
    c_detail varchar (255),
    PRIMARY KEY (cid)
);
CREATE TABLE IF NOT EXISTS discussion_forum(
	cid varchar (255),
    forum_id varchar (255),
    forum_description varchar(255),
    primary key (cid,forum_id)
);
CREATE TABLE IF NOT EXISTS section(
	cid varchar(255),
    section_id varchar (255),
    s_name varchar(255),
    s_description varchar(255),
    primary key (cid,section_id)
);
CREATE TABLE IF NOT EXISTS sectionitem(
	cid varchar (255),
    section_id varchar (255),
    iid int,
    si_name varchar (255),
    si_details varchar (255),
    primary key(cid,section_id,iid)
);
CREATE TABLE IF NOT EXISTS calendarevent(
	cid varchar (255),
    eid int,
    event_name varchar (255),
    e_date date,
    e_detail varchar (255),
    primary key(cid,eid)
);
CREATE TABLE IF NOT EXISTS assignment(
	cid varchar (255),
    assignment_id varchar (255),
    duedate date,
    primary key (cid,assignment_id)
);
CREATE TABLE IF NOT EXISTS manage(
	cid varchar (255),
    uid int,
    yyear date,
    primary key (cid,uid)
);
CREATE TABLE IF NOT EXISTS edit(
	eid varchar (255),
    uid int,
    primary key(eid,uid)
);
CREATE TABLE IF NOT EXISTS uupdate(
	uid int,
    iid int,
    primary key (uid,iid)
);
CREATE TABLE IF NOT EXISTS ccreate(
	uid int,
    section_id varchar (255),
    creationdate date,
    primary key (uid,section_id)
);
CREATE TABLE IF NOT EXISTS moderate_reply(
	uid int,
    thread_id int,
    activitydate date,
    primary key (uid,thread_id)
);
CREATE TABLE IF NOT EXISTS enrol(
	uid int,
    cid varchar (255),
    grade varchar (2),
    primary key (uid,cid)
);
CREATE TABLE IF NOT EXISTS submit(
	uid int,
    assignment_id varchar (255),
    grade varchar (2),
    primary key (uid,assignment_id)
);
CREATE TABLE IF NOT EXISTS enlist(
	uid int,
    cid varchar (255),
    creationdate date
);