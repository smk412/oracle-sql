-- 함수
SELECT profno
    , name
    , pay
    , nvl(bonus, 0) bonus
    ,pay*12 + nvl(bonus, 0)*3 AS "연봉"
FROM professor;

-- initcap ('문자열'/ 칼럼)
SELECT initcap('hello')
FROM dual;

SELECT profno
      --,LOWER(name)
      --,UPPER(name)
      --,LENGTH(name)
      --,CONCAT(profno, name)
      --,SUBSTR(name, 1, 0)
      FROM professor;
      
      
      
SELECT ename, INITCAP(ename) "INITCAP"
FROM emp
WHERE deptno = 10;

SELECT ename, LOWER(ename) "LOWER", UPPER(ename) "UPPER"
FROM emp
WHERE deptno = 10;

SELECT ename, LENGTH(ename) "LENGTH", LENGTHB(ename) "LENGTH"
FROM emp
WHERE deptno = 20;

-- 예1) 교수테이블의 이름에 'st'(대소문자 구분없이)가 포함된 교수의 교수번호
SELECT name, profno
FROM professor
WHERE LOWER(name) LIKE '%st%';

-- 예2) 교수테이블의 교수이름이 10글자가 안되는 교수의 번호, 이름, 이메일 출력
SELECT profno, name, email
FROM professor
WHERE LENGTH(name) < 10;

-- substr
SELECT 'hello, world'
        ,substr('hello, world', 1, 5) substr1 -- +값이면 왼쪽 순번
        ,substr('hello, world', -5, 5) substr2 -- -값이면 오른쪽부터 왼쪽순번
        ,substr('0' || 5, -2, 2) mm
        , substr('02)3456-2345', 1, instr('02)3456-2345', ')', 1) - 1) instr1
        , substr('031)2345-2312', 1, instr('031)2345-2312', ')', 1) - 1) instr1
        , instr('031)2345-2312', ')', 1) instr2 -- 문자열에서 찾을 문자열의 위치 반환
FROM  dual;

-- 예제3) 학생테이블의 tel 컬럼을 사용하여 1 전공번호가 201번인 학생의 이름과 전화번호가 나오는 위치를 출력
SELECT 
    substr(tel, 1, instr(tel, ')') -1 ) "지역번호"
    , name
    , substr(tel, instr(tel, ')')+1, instr(tel, '-') - instr(tel, ')')-1) "전화번호 앞 자리"
FROM student
WHERE deptno1 = 201;

select tel, LENGTH(tel), INSTR(tel, ')'), INSTR(tel, '-'), substr(tel, 5, INSTR(tel, '-'))
from student;


-- 예제4) 학생 테이블에서 1전공이 101번인 학생들의 tel컬럼을 조회하여 
--       3이 첫 번쨰로 나오는 위치를 이름과 전화번호와 함께 출력
SELECT name, tel, deptno1, instr(tel, '3')
FROM student
WHERE deptno1 = 101;


SELECT RPAD('hello', 10, '*')
FROM dual;


-- LPAD퀴즈
SELECT 
    -- LPAD(ename, 9, '1234567') LPAD
    --,RPAD(ename, 10, '-') RPAD
    RPAD(ename, 9, SUBSTR('123456789', LENGTH(ename) +1)) RPAD
FROM emp
WHERE deptno = 10;


-- LTRIM('값', '찾을 문자열')
SELECT RTRIM ('Hello', 'o')
FROM dual;

-- REPLACE('값', '찾을 문자열', '대체 문자열')
SELECT ename
      ,REPLACE(ename, substr(ename, 1, 2), '**') REPLACE
      ,SUBSTR(ename, 1, 2) DESTINATION
FROM emp;

-- REPLACE 퀴즈1)emp테이블에서 아래와 같이 20번 부서에 소속된 직원들의 이름과 2~3번째 글자만 '-'으로 변경해서 출력하세요
SELECT ename, REPLACE(ename, SUBSTR(ename, 2, 2), '--') REPLACE, SUBSTR(ename, 2, 2) DESTINATION
FROM emp
WHERE deptno = 20;

-- REPLACE 퀴즈2) 학생테이블에서 1전공이 101번인 학생들의 이름과 주민등록번호를 출력하되,
--               주민번호 뒷 7자리는 '-'과 '/'로 표시되게 출력하시오.
SELECT name, REPLACE(jumin, SUBSTR(jumin, 7, 7), '-/-/-/-') "주민등록번호"
FROM student
WHERE deptno1 = 101;

-- REPLACE 퀴즈3) 학생테이블에서 1전공이 102번인 학생들의 
--               이름과 전화번호, 전화번호에서 국번 부분만 '*'처리하여 출력하세요 (모든 국번은 3자리로 간주)
SELECT 
    name,
     tel,
     REPLACE(
        tel,
        SUBSTR(tel, INSTR(tel, ')') + 1, INSTR(tel, '-') - INSTR(tel, ')') - 1),
        '***'
     ) REPLACE
FROM student
WHERE deptno1 = 102;

-- REPLACE 퀴즈4) 학생테이블에서 1전공이 101번인 학생들의 
--               이름과 전화번호와 전화번호에서 지역번호와 국번을 제외한 나머지 번호를 *로 표시해서 출력하세요
SELECT
    name,
    tel,
    REPLACE(
        tel,                              -- 사용될 COL
        SUBSTR(tel, INSTR(tel, '-') + 1), -- 대체될 내용 (국번)
        '****'                            -- 대체할 내용 ('*')
    ) REPLACE
FROM student
WHERE deptno1 = 101;


-- ROUND()
SELECT ROUND(123.456, 1)
      ,trunc(123.4567, -1)
      ,mod(12, 5)
      ,ceil(12.3)
      ,floor(12.3)
      ,trunc(sysdate)
      ,to_char(trunc(sysdate, 'hh'), 'rrrr/mm/dd hh24:mi:ss') trunc2
FROM dual;


SELECT add_months(sysdate, 1) next_month
      ,months_between(sysdate + 28, sysdate) months
FROM dual;


-- 사원번호, 이름, 근속년수 (23년)
-- 사원번호, 이름, 근속년수 (23년 7개월)
SELECT 
    empno,
    ename,
    hiredate,
    trunc(months_between(sysdate, hiredate) / 12) || '년' "근속년수",
    trunc(months_between(sysdate, hiredate) / 12) || '년' 
    || mod(trunc(months_between(sysdate, hiredate)), 12) || '개월' "근속년수2"
FROM emp;

-- 교수번호, 이름, 입사일자, 급여 (20년 이상, Software Engineering)
SELECT 
    profno,
    name,
    hiredate,
    position,
    dname,
    (pay * 12 + nvl(bonus, 0) * 3) "연봉" ,
    trunc(months_between(sysdate, hiredate) / 12) "근속년수",
    P.deptno
FROM professor P, department D
WHERE trunc(months_between(sysdate, hiredate) / 12) >= 20
AND p.deptno = D.deptno
AND D.dname = 'Software Engineering'
ORDER BY 3;


-- SAELS 부서에서 근속년 40년이 넘는 사람. 사번, 이름, 급여, 부서명
SELECT *
FROM emp E, dept D
WHERE E.deptno = D.deptno
AND D.dname = 'SALES'
AND (MONTHS_BETWEEN(sysdate, hiredate) / 12) >= 40
ORDER BY E.empno; 

SELECT 2 + to_number('2', 9)
    ,CONCAT(2, '2')
    ,sysdate
FROM dual
WHERE sysdate > '2026/02/03';

-- to_char(날짜, '포맷문자')
SELECT sysdate
        ,to_char(sysdate, 'RRRR-MONTH-DD HH24:MI:SS') to_char
        ,to_date('05/2024/03', 'DD/RRRR/MM') to_date
FROM dual;

SELECT to_char(12345.6789, '099,999.99') -- 반올림 한 연산결과를 문자출력
FROM dual;

-- 형변환 연습1) 생일이 1월인 학생의 이름과 birthday 출력
SELECT name, to_char(birthday, 'DD-MON-RR') BIRTHDAY
FROM student
WHERE to_char(birthday, 'MM') = '01';


-- nvl()
SELECT nvl(10, 0) -- null ? 0 : 10
FROM dual;

SELECT pay + nvl(bonus, 0) "월급"
FROM professor;

-- student(profno) -> 9999(없으면)/ 담당교수번호
--                     담당교수없음/ 담당교수번호

SELECT nvl(profno, 9999) prof1
       ,nvl(profno||'', '담당교수없음')prof2
FROM student
ORDER BY 1 DESC;

-- decode(A, B, '같은조건', '다른조건')
SELECT decode(10, 20, '같다', '다르다') -- 10 == 20 ? '같다' : '다르다'
FROM dual;

SELECT studno, profno, decode(profno, null, 9999, profno)
FROM student
ORDER BY profno desc;

SELECT decode('C', 'A', '현재A', 'B', '현재B', '기타')
FROM dual;

SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering', null) 
FROM professor
WHERE deptno = 101;

-- 학생테이블의 생년월일을 기준으로 1~3 -> 1/4분기. 4~6 -> 2/4분기. . .
SELECT 
    name,
    birthday,
    DECODE(SUBSTR(birthday, 6, 2) 
FROM student;

-- DECODE 연습1) 학생 테이블에서 1전공이 101번인 학생들의 이름과 주민번호, 성별을 출력하되
             -- 성별은 주민번호를 이용하여 7번째 숫자가 1일 경우 "MAN", 2일 경우 "WOMAN"
SELECT name, jumin, DECODE(SUBSTR(jumin, 7,1), '1', 'MAN', '2', 'WOMAN') "성별"
FROM student
WHERE deptno1 = 101;

-- DECODE 연습2) 학생 테이블에서 1전공이 101번인 학생의 이름과 연락처와 지역을 출력하세요
--              지역번호 02 -> 'SEOUL', 지역번호 031 -> 'GYEONGGI',
--              지역번호 051 -> 'BUSAN', 지역번호 052 -> 'ULSAN'
SELECT NAME, TEL, 

-- 학과
SELECT *
FROM department;

SELECT profno, name, p.deptno, dname
FROM professor p, department d -- 데이터 개수 : 16 x 12 = 192
WHERE p.deptno = d.deptno
AND d.dname = 'Computer Engineering';


-- 2026.02.03 (화) TODO

-- P.107


-- P.108


-- P.113(nv12)


-- 학생테이블의 생년월일을 기준으로 1~3 -> 1/4분기. 4~6 -> 2/4분기. . .