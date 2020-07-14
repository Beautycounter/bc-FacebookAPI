use Facebook

IF(
	SELECT TOP 1 1 
	FROM sys.tables t 
	inner join sys.schemas s
	on t.schema_id = s.schema_id
		where s.name = 'campaigns'
		and t.name = 'campaigns_archive'
) IS NOT NULL
	DROP TABLE campaigns.campaigns_archive;

Create Table campaigns.campaigns_archive
(
	 PKID BIGINT Identity(1,1)
	,campaignId VARCHAR(200) NOT NULL
	,startDateTimeUTC datetimeoffset(0)
	,updateDateTimeUTC datetimeoffset(0)
	,archiveDateTimeUTC datetimeoffset(3)
	,campaignStatus VARCHAR(500) 
	,data_ nvarchar(max)
	,isLatest bit
)
CREATE CLUSTERED INDEX idx_Campaign ON campaigns.campaigns_archive (campaignId,isLatest)