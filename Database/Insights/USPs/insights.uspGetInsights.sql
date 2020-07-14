use facebook

IF(
SELECT top 1 1
from sys.schemas s
inner join sys.procedures p 
on s.schema_id = p.schema_id
where 
	s.name = 'insights' 
and p.name = 'uspGetInsights'
) IS NOT NULL
	DROP PROC insights.uspGetInsights
GO

CREATE PROC insights.uspGetInsights
AS BEGIN

	select 
		 c.campaignId
		,c.campaignStatus
		,MAX(ISNULL(i.insightDateTimeUTC,CAST(c.startDateTimeUTC AS DATE))) startDate
		,CAST(GETDATE() AS DATE) endDate
	from campaigns.campaigns_archive c
	left outer join Insights.insights_archive i
		on c.campaignId = i.campaignId
	group by c.campaignId, c.campaignStatus

END
