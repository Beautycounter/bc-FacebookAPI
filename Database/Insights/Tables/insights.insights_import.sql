
use Facebook

IF(
	SELECT TOP 1 1 
	FROM sys.tables t 
	inner join sys.schemas s
	on t.schema_id = s.schema_id
		where s.name = 'insights'
		and t.name = 'insights_import'
) IS NOT NULL
	DROP TABLE insights.insights_import;

Create Table insights.insights_import
(
	 PKID BIGINT Identity(1,1)
	,campaignId varchar(200)
	,insightDateTimeUTC varchar(200)
	,importDateTimeUTC datetimeoffset(3)
	,data_ nvarchar(max)
)


