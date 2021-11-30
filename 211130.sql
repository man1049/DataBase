use paging;

CREATE table sports(
	spnum integer auto_increment primary key,
	spname varchar(20)
);

insert into sports(spname) values('농구');
insert into sports(spname) values('배구');
insert into sports(spname) values('야구');
insert into sports(spname) values('축구');
insert into sports(spname) values('마라톤');
insert into sports(spname) values('골프');
insert into sports(spname) values('테니스');
insert into sports(spname) values('스키');
insert into sports(spname) values('체조');
insert into sports(spname) values('멀리뛰기');