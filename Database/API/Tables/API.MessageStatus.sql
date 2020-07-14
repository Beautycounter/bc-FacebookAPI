
USE [facebook]

--[Orders].[MessageStatus]
--Status Codes for the logger
CREATE TABLE [API].[MessageStatus]
(
	 PKID BIGINT IDENTITY (1,1)
	,MessageStatusCode INT NOT NULL
	,MessageStatus VARCHAR(500) NOT NULL
)
CREATE NONCLUSTERED INDEX Idx_MessageStatus ON [API].[MessageStatus] (MessageStatusCode, MessageStatus)

INSERT [API].[MessageStatus]
SELECT 0,'No Error'
UNION
SELECT 1,'Fatal Error'
UNION
SELECT 2,'NonFatal Error'
UNION 
SELECT 3,'Warning'

SELECT * FROM [API].[MessageStatus]
