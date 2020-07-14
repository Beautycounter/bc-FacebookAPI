use [facebook]

--CREATE TABLE [Orders].[Logger]
--Create Logger Table for Orders Parsing
DROP TABLE [API].[Logger]
CREATE TABLE [API].[Logger]
(
	 PKID BIGINT PRIMARY KEY IDENTITY(1,1) 
	,LogID BIGINT NOT NULL
	,LogTimeStampUTC DATETIMEOFFSET(3) DEFAULT GETUTCDATE()
	,Process VARCHAR(500) NOT NULL
	,MessageStatusCode INT NOT NULL
	,MessageText VARCHAR(MAX) NOT NULL
)
CREATE NONCLUSTERED INDEX Idx_Logger ON [API].[Logger] (LogTimeStampUTC, Process, MessageStatusCode)

