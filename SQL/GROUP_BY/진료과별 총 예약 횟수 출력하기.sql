-- 문제: 진료과별 총 예약 횟수 출력하기
-- https://school.programmers.co.kr/learn/courses/30/lessons/132202

SELECT MCDP_CD AS '진료과 코드',
count(*) AS '5월예약건수'
FROM APPOINTMENT
WHERE APNT_YMD BETWEEN '2022-05-01' AND '2022-05-31'
-- WHERE APNT_YMD LIKE '2022-05%'
-- WHERE DATE_FORMAT(APNT_YMD, '%Y-%m') = '2022-05'
GROUP BY MCDP_CD
ORDER BY 5월예약건수 ASC,MCDP_CD ASC
