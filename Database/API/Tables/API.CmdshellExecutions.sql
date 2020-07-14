
USE [facebook]

DROP TABLE API.CmdshellExecutions
CREATE TABLE API.CmdshellExecutions
(
	 PKID BIGINT PRIMARY KEY IDENTITY(1,1)
	,[BQtype] VARCHAR(MAX)
	,[Path_] VARCHAR(MAX)
	,[Args_] VARCHAR(MAX)
)

