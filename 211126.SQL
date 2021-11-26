use employees;
show tables;
select * from employees;

-- usertbl에서 name과 addr을 조회하는데 name에는 이름 그리고 addr에는 주소라는 새로운 이름을
-- 부여해서 조회하고 name의 내림차순으로 조회
select name 이름 , addr 주소
from usertbl
order by 이름 desc ;

select name 이름 , addr 주소
from usertbl
order by name desc ;

select name 이름 , addr 주소
from usertbl u
order by u.name desc ;

-- 테이블 이름에 새로운 이름을 부여했을 때는 반드시 새로 부여한 이름을 사용해야함 - 에러
select name 이름 , addr 주소
from usertbl u
order by usertbl.name desc ;

-- usertbl 테이블에서 userid를 모두 대문자로 조회하고 name과 birthyear를 조합해서 조회
select upper(userid), concat(name,birthyear) 
from usertbl;

-- 1986년 5월 5일 11시를 날짜형식으로 생성

select str_to_date('1986/05/05 11:00:00','%Y/%m/%d %H:%i:%S');

-- 오늘 날짜와 1986년 5월 5일의 날짜 차이 구하기

select datediff(now(), str_to_date('1986/05/05','%Y/%m/%d')) ;

select user();

select database();

select version(); 


-- usertbl 테이블에서 birthyear의 name과 함께 순위를 구해서 출력하세요
select name, birthyear, rank() over (order by birthyear desc)
from usertbl;

-- usertbl 테이블의 구조 확인
desc usertbl;

-- usertbl 테이블에 userid가 kjn이고 name은 제니,
-- birthyear는 1996, addr은 서울, mobile은 01012341234,
-- mdate는 1996년 1월 16일 데이터를 추가
insert into usertbl(userid,name,birthyear,addr,mobile,mdate) values('kjn','제니',1996,'서울','01012341234',str_to_date('1996-01-16','%Y-%m-%d'));

-- usertbl 테이블에서 userid가 kjn인 데이터의 name을 김제니로 수정
update usertbl 
set name = '김제니'
where userid ='kjn';

-- usertbl 테이블에서 userid가 kjn인 데이터를 삭제
delete from usertbl where userid = 'kjn';

select * from usertbl;
select * from buytbl;

select *
from usertbl,buytbl;

-- usertbl 테이블과 buytbl테이블을 equi join 하는데 양쪽 테이블에 모두 존재하는 컬럼은 userid

select *
from usertbl u
inner join buytbl b on u.userid = b.userid 

-- 양쪽 테이블의 join 컬럼 이름이 동일하면 inner join 대신에 natural join이라고 입력하고 on절을 생략해도됨
select *
from usertbl natural join buytbl;

-- outer join

-- left outer join
select *
from usertbl u
left outer join buytbl b on u.userid = b.userid

-- right outer join
select *
from usertbl u
right outer join buytbl b on u.userid = b.userid;

-- full outer join MySQL에서는 full outer join을 지원하지않음
select *
from usertbl u
left outer join buytbl b on u.userid = b.userid
union
select *
from usertbl u
right outer join buytbl b on u.userid = b.userid;

-- 테이블 생성
drop table backsan;
create table backsan(
	num integer auto_increment primary key,
	name varchar(10) not null,
	age integer not null,
	phone varchar(11) unique,
	email varchar(100) unique
) engine = myisam auto_increment=1 default charset=utf8;

create table addr(
	num integer references backsan(num) on delete cascade,
	addr char(100),
	primary key(num,addr))
	engine = myisam auto_increment=1 default charset=utf8;

-- 구조 확인
desc backsan;

-- 컬럼 자료형 수정

-- birthday를 날짜형으로 추가
alter table backsan add birthday date;

-- age를 정수에서 실수로 수정
alter table backsan modify age double;

-- age 컬럼을 삭제
alter table backsan drop age;

-- 제약조건 수정 - not null을 설정하는 경우
alter table 테이블이름 modify 컬럼이름 자료형 제약조건;

-- 제약조건 추가
alter table 테이블이름 add 제약조건(컬럼이름);

-- 제약조건 삭제
alter table 테이블이름 drop constraint 제약조건이름;

-- 테이블 삭제
drop table 테이블이름;

-- 모든 데이터 삭제
truncate table 테이블이름;

-- 테이블 이름 변경
alter table 이전테이블명 rename 새로운테이블명;

-- 임시테이블
-- 테이블을 만들 때 create 다음에 temporary table만 추가하면 됨
-- 사용법은 일반 테이블과 같고 세션이 종료되면 자동으로 소멸

-- view
-- 가상의 테이블
-- 자주 사용하는 select 구문을 하나의 이름으로 만들어두고 테이블 처럼 사용하는 것
-- 삽입과 삭제및 갱신에 제약은 있음

-- 생성
create [or replace] view 이름
as
select 구문
[with check option]
[with read only];

-- 삭제
drop view 뷰이름;

-- index
-- 데이터를 빠르게 조회하기 위해 사용하는 개체

-- 장점
-- 조회속도가 빠름
-- 쿼리의 부하가 줄어듦

-- 단점
-- 추가 공간이 필요
-- 처음 인덱스를 생성시 시간이 많이 소모 될 수 있음
-- 데이터변경이 빈번히 발생하면 성능이 나빠질 수 있음

-- 종류
-- 클러스터드 인덱스 : 데이터를 물리적으로 인덱스 순서와 동일하게 만드는 인덱스로 테이블에 1개만 생성
-- 보조인덱스

-- 자동으로 생성되는 인덱스
-- primary key 제약조건 - 클러스터드 인덱스
-- unique 제약조건

-- 인덱스 생성
create index 인덱스이름 on 테이블이름(컬럼이름 나열하거나 연산식);

-- 인덱스 제거
drop index 인덱스이름;

-- userid를 이용해서 조회하는데 인덱스를 사용하는지 확인
explain select *
from usertbl
where userid = 'kty';

-- 인덱스를 사용하지 않은 경우
explain select *
from usertbl
where addr = '서울';

-- 인덱스를 생성 : addr을 이용해서 조회하면 조회속도가 빨라집니다.
create index idx_addr on usertbl(addr);

explain select *
from usertbl
where addr = '서울';

-- 절차적프로그래밍 (sql은 비절차적)
-- SQL은 광계형 데이터베이스 별로 비슷하지만 절차적 프로그래밍 부분은 데이터베이스별로 문법이 다름
-- 오라클의 절차적 프로그래밍 문법을 PL/SQL 이라고 하고 MS-SQL SERVER의 절차적 프로그래밍 문법을 T-SQL 이라고 함

-- procedure
-- 자주 사용하는 sql 문장을 함수처럼 하나의 문장으로 만들어두고 사용하는 것
-- 프로시저나 뷰는 한 번 실행되면 메모리에 상주를 하기 떄문에 다음 부터는 실행속도가 빨라짐
-- 모듈화 프로그래밍(나누어서 프로그래밍) 가능

-- function
-- 매개변수를 받아서 가공을 한 후 결과를 리턴

-- trigger
-- DML 문장을 호출 할 때(이벤트) 다른 문장을 수행하는 것
-- 실행되기 전의 동작을 지정 할 수도 있고 실행 된 후의 동작을 지정 할 수도 있음
-- 실행되기 전에 하는 일은 데이터의 유효성을 검사하거나 시간대 등을 확인해서 조건에 맞지 않으면 작업을 수행하지 않도록 함

-- 실행 된 후에 하는 일은 자동으로 다른 테이블에 데이터를 삽입하는 작업을 많이 하는데 이 작업 중에는
-- 로그를 기록하는 일도 있음






