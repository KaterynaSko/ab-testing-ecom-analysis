--converted user by group

SELECT 
    variant,
    COUNT(user_id) AS total_users,
    SUM(converted) AS converted_users,
    ROUND(AVG(converted) * 100, 2) AS cr_percent
FROM 
    ab_test_results
GROUP BY 
    variant;


--average ssesion duration time by group
 
SELECT variant, round(avg (session_duration),3) AS avg_session_time
FROM ab_test_results atr 
GROUP BY atr.variant;


--average pages viseted by group

SELECT variant, round(avg (atr.pages_visited),3) AS avg_pages_visited
FROM ab_test_results atr 
GROUP BY atr.variant;


--user segmentation by age 

SELECT 
    CASE 
        WHEN age < 25 THEN '< 25'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END AS age_group,
    variant,
    ROUND(AVG(session_duration), 3) AS avg_session_time,
    ROUND(AVG(pages_visited), 3) AS avg_pages_visited
FROM 
    ab_test_results
GROUP BY age_group, variant
ORDER BY 
    CASE 
        WHEN age < 25 THEN 1
        WHEN age BETWEEN 25 AND 34 THEN 2
        WHEN age BETWEEN 35 AND 44 THEN 3
        ELSE 4
    END,
    variant;