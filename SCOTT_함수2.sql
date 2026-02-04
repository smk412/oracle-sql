SELECT name
    ,to_char(birthday, 'Q') || '/4분기' quarter1
    ,ceil(to_char(birthday, 'MM') / 3) || '/4분기' quarter2
    ,decode(to_char(birthday, 'MM')
            ,'01', '1/4분기', '02', '1/4분기','03', '1/4분기'
            ,'04', '2/4분기', '05', '2/4분기','06', '2/4분기' 
            ,'07', '3/4분기', '08', '3/4분기','09', '3/4분기'
            ,'10', '4/4분기', '11', '4/4분기','12', '4/4분기')
            quarter3 -- 03, 04, 05, . . 일일히 대입
            
FROM student;

SELECT *
FROM emp;

SELECT e.*, dname, loc
FROM dept d, emp e
WHERE e.deptno = d.deptno;


-- ANSI vs. ORACLE
SELECT *
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE job = 'SALESMAN';

-- student(profno), professor
-- 학생번호, 이름, 담당교수번호, 이름
SELECT studno, s.name, s.profno, p.name "담당교수이름"
FROM student s
-- JOIN professor p ON s.profno = p.profno;
-- LEFT OUTER JOIN professor p ON s.profno = p.profno;  --student가 메인테이블
right OUTER JOIN professor p ON s.profno = p.profno;  --student가 보조테이블

-- 먼저 나오는게 left, 나중에 나오는게 right? 헷갈리네 ㅋ
-- student, professor (student가 기준, professor가 보조 테이블이 되겠다)

-- 학생번호, 학생이름, 담당교수이름 / 담당교수없음
SELECT
    studno,
    s.name,
    nvl(p.name, '담당교수없음') "담당교수"
FROM student s
LEFT OUTER JOIN professor p ON s.profno = p.profno;

-- nvl(), decode(), case when end
-- student 지역번호 구분 | 02 : 서울 | 031 : 경기도 | 051 : 부산 | 그외 : 기타
SELECT 
    name,
    SUBSTR(tel, 1, INSTR(tel, ')') - 1) TEL,
    CASE SUBSTR(tel, 1, INSTR(tel, ')') - 1) WHEN '02' THEN '서울'
                                             WHEN '031' THEN '경기도'
                                             WHEN '051' THEN '부산'
                                             ELSE '기타'
    END "지역명"                               
FROM student;

SELECT 
    name,
    jumin,
    SUBSTR(jumin, 3, 2) "MM",
    CASE WHEN SUBSTR(jumin, 3, 2) BETWEEN '01' AND '03' THEN '1/4분기'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '04' AND '06' THEN '2/4분기'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '07' AND '09' THEN '3/4분기'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '10' AND '12' THEN '4/4분기'
    END "분기"
FROM student;

-- CASE 퀴즈1) emp 테이블에서 empno, ename, sal, LEVEL(급여등급)을 출력하시오
--            급여등급 | sal 기준으로,
--                      Level 1 (1 - 1000)
--                      Level 2 (1001 - 2000) . . . Level 5 (4001 이상)
SELECT
    empno,
    ename,
    sal,
    CASE WHEN sal BETWEEN '1' AND '1000' THEN 'LEVEL 1'
         WHEN sal BETWEEN '1001' AND '2000' THEN 'LEVEL 2'
         WHEN sal BETWEEN '2001' AND '3000' THEN 'LEVEL 3'
         WHEN sal BETWEEN '3001' AND '4000' THEN 'LEVEL 4'
         ELSE 'LEVEL 5'
    END "급여등급"
FROM emp;
    
SELECT 
    job,
    count(job),
    round(avg(sal), 1),
    min(hiredate),
    max(hiredate)
FROM emp
GROUP BY job;


-- 부서별 급여합계, 평균급여, 인원
--SELECT job, sum(sal + nvl(comm, 0)), round(avg(sal + nvl(comm, 0)), count(job)

SELECT 
    d.dname,
    sum(sal + nvl(comm, 0)) "급여합계",
    round(avg(sal + nvl(comm, 0))) "급여평균",
    count(d.dname) "부서별 인원수"
FROM emp e
LEFT OUTER JOIN dept d ON d.deptno = e.deptno
GROUP BY d.dname;

SELECT 
    d.dname,
    e.*
FROM (SELECT 
            deptno,
            sum(sal + nvl(comm, 0)) "급여합계",
            round(avg(sal + nvl(comm, 0))) "급여평균",
            count(*) "부서별 인원수"
      FROM emp
      GROUP BY deptno) e
JOIN dept d ON d.deptno = e.deptno;