use Facebook

IF(
	SELECT TOP 1 1 
	FROM sys.tables t 
	inner join sys.schemas s
	on t.schema_id = s.schema_id
		where s.name = 'campaigns'
		and t.name = 'campaigns_import'
) IS NOT NULL
	DROP TABLE campaigns.campaigns_import;

Create Table campaigns.campaigns_import
(
	 PKID BIGINT Identity(1,1)
	,campaignId VARCHAR(200) NOT NULL
	,startDateTimeUTC varchar(100)
	,updateDateTimeUTC varchar(100)
	,importDateTimeUTC datetimeoffset(3)
	,campaignStatus VARCHAR(500) 
	,data_ nvarchar(max)
)
