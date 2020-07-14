
use Facebook

IF(
	SELECT TOP 1 1 
	FROM sys.tables t 
	inner join sys.schemas s
	on t.schema_id = s.schema_id
		where s.name = 'Insights'
		and t.name = 'insights_archive'
) IS NOT NULL
	DROP TABLE Insights.insights_archive;

Create Table Insights.insights_archive
(
	 PKID BIGINT Identity(1,1)
	,campaignId varchar(200)
	,insightDateTimeUTC varchar(200)
	,archiveDateTimeUTC datetimeoffset(3)
	,data_ nvarchar(max)
	,isLatest bit
)
CREATE Clustered index idx_archive on Insights.insights_archive(campaignId,insightDateTimeUTC,isLatest)