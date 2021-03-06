

CREATE DATABASE PerformanceTest
GO
USE PerformanceTest
GO



CREATE TABLE CoveredIndexTest ( Col1 INT NOT NULL , Col2 NVARCHAR(2047) NOT NULL ); 

INSERT CoveredIndexTest (Col1, Col2) VALUES (0, 'A lonely row...'); 

INSERT CoveredIndexTest (Col1, Col2) 
SELECT TOP(999999)  message_id, text 
FROM sys.messages AS sm CROSS JOIN 
( 
	SELECT TOP(15) 1 AS Col  
	FROM sys.messages 
)AS x 

SELECT COUNT(*) AS [Count] FROM CoveredIndexTest
GO 

SET STATISTICS IO ON
GO 



-- Query #1 -- Returns 1 row.
SELECT Col1, Col2 FROM CoveredIndexTest
    WHERE Col1 = 0;


-- Query #2  -- Returns roughly 0.1% of the rows found in the table.
SELECT Col1, Col2 FROM CoveredIndexTest
    WHERE Col1 BETWEEN 1205 AND 1225;


-- Query #3 -- Returns roughly 0.5% of the rows found in the table.
SELECT Col1, Col2 FROM CoveredIndexTest
    WHERE Col1 BETWEEN 1205 AND 1426;  

    
-- Query #4 (non-selective) -- Returns roughly 5% of the rows found in the table.
SELECT Col1, Col2 FROM CoveredIndexTest
    WHERE Col1 BETWEEN 1205 AND 2298;


-- Non-covered index 
CREATE NONCLUSTERED INDEX NonCovered ON CoveredIndexTest (Col1);

-- Covered index 
CREATE NONCLUSTERED INDEX Covered ON CoveredIndexTest (Col1) INCLUDE (Col2);

