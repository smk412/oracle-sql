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
select name || '의 아이디는 ' || id  as "전체설명" --별칭(alias)
 ,grade "학년"
from student;

-- James Seo 의 아이디는 75true이고, 4학년입니다. -> alias (학년설명)
select name || '의 ''아이디''는 ' || id || '이고, ' || grade || '학년입니다.' as "학년설명"
from student;

SELECT distinct name, grade -- 중복된 값 제거
FROM student;

SELECT *
FROM emp;

-- 연습1)
select name || '''s ID: ' || id || ' , WEIGHT is ' || weight || 'kg' as "ID AND WEIGHT"
FROM student;

-- 연습2)
SELECT ename || '(' || job || '),' || ename || '''' || job || '''' as "NAME AND JOB"
FROM emp;

-- WHERE
SELECT *
FROM student
WHERE weight between 60 and 70
AND deptno1 in (101, 201);

SELECT *
FROM student
WHERE deptno2 is not null;

-- 비교연산자 연습1)emp 테이블 급여 3000보다 큰 직원
SELECT EMPNO || ', ' || ENAME AS "직원"
FROM emp
WHERE SAL > 3000;

-- 비교연산자 연습2) EMP 테이블 보너스 있는 직원
SELECT EMPNO || ', ' || ENAME AS "직원"
FROM emp
WHERE COMM IS NOT null;

-- 비교연산자 연습3) student 테이블 주전공학과 : 101, 102, 103인 학생
SELECT STUDNO || ', ' || NAME || ' : ' || DEPTNO1 AS "학생"
FROM student
WHERE DEPTNO1 IN(101, 102, 103);

-- 급여가 2000 이상이거나 커미션(급여 + 커미션)이 2000 이상인 직원
SELECT *
FROM emp
WHERE SAL >= 2000
OR (SAL + COMM >= 2000);

-- 교수 => 연봉이 5000 이상인, 보너스 3번
SELECT profno 
    , Name 
    ,pay 
    ,bonus
    , pay * 12 as total_1
    , (pay *12 + bonus * 3) as total_2
FROM PROFESSOR
WHERE pay * 12 >= 3000 and bonus is null
OR (pay * 12 + bonus * 3 >= 4000 AND bonus is not null)
ORDER BY 5;



-- 문자열 LIKE 연산자
SELECT *
FROM student
WHERE name like '%on____%';

--
SELECT profno, name, id, pay, bonus, hiredate
FROM PROFESSOR
WHERE hiredate > to_date('99-01-01', 'RR-MM-DD')
ORDER BY hiredate;

-- 학생테이블, 전화번호(02, 031, 051, 052, 053 . .)
-- 부산 거주하는 학생
SELECT *
FROM student
WHERE tel LIKE '051%';

-- 이름 M으로 시작하면서 8자 이상인 사람만 조회
SELECT *
FROM student
WHERE name LIKE 'M_______%';

--주민번호 10월달에 태어난 사람 조회
SELECT *
FROM student
WHERE jumin LIKE '__10%';


-- AND / OR
-- IF (sal > 100 || height > 170)
SELECT studno, name, id, grade, height, weight
FROM student
WHERE HEIGHT > 170
OR WEIGHT > 60
AND GRADE = 4; -- AND 연산 우선순위가 OR보다 더 높음 (1. A AND B. 2. OR C)

SELECT studno, name, id, grade, height, weight
FROM student
WHERE (HEIGHT > 170
OR WEIGHT > 60)
AND GRADE = 4; -- 충족조건 2개 (1. A AND (B OR C))

-

