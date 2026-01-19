-- Week 1 Day 1
-- Topic: SQL Level 1 - SELECT / WHERE / GROUP BY
-- Source: Programmers Lv.1

-- 1) 전체 조회
SELECT *
FROM sample_table
LIMIT 10;

-- 2) 조건 조회
SELECT *
FROM sample_table
WHERE condition_column = 'value';

-- 3) 집계
SELECT category, COUNT(*) AS cnt
FROM sample_table
GROUP BY category;
