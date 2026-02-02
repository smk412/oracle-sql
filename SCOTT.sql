-- Oracle (DBMS) - version(21c) - xe (database명)
-- user (scott) - 테이블
-- Structured Query Language(SQL)
SELECT *  -- 컬럼명(전체)
from student; -- 테이블


-- 1) professor 테이블, 전체 컬럼 조회.
select * from professor;

-- 2) 학생 -> 학생번호, 이름, 학년
select studno, name, grade
from student;

-- 숙제 완료함.
