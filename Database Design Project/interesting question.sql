CREATE INDEX STRUCTUREINX on
allbridge(ADT_029 , PERCENT_ADT_TRUCK_109);
SELECT STATE_CODE_001, AVG((ADT_029 * PERCENT_ADT_TRUCK_109)) AS TRUCKavgNUM
FROM project.allbridge
WHERE YEAR_BUILT_027 > 2010 AND YEAR_ADT_030 > 2010
GROUP BY STATE_CODE_001
ORDER BY TRUCKavgNUM DESC;