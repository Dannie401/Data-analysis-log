-- 문제: 고양이와 개는 몇 마리 있을까
-- https://school.programmers.co.kr/learn/courses/30/lessons/59040

SELECT
ANIMAL_TYPE,
count(*) AS "count"
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE ASC;

/*
SELECT ANIMAL_TYPE, COUNT(*) AS "count"
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY 
    CASE WHEN ANIMAL_TYPE = 'Cat' THEN 1 
         WHEN ANIMAL_TYPE = 'Dog' THEN 2 
         ELSE 3 END;
*/
