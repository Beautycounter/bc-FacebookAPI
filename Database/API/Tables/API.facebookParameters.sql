use [facebook]

DROP TABLE API.facebookParameters
CREATE TABLE API.facebookParameters
(
	 PKID BIGINT Primary Key IDENTITY(1,1)
	,[BQType] VARCHAR(50) NOT NULL
	,[Key] VARCHAR(50) NOT NULL
	,[VALUE] NVARCHAR(MAX) NOT NULL
)