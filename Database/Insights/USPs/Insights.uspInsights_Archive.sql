
use facebook

IF (SELECT TOP 1 1 
	FROM sys.procedures p 
	inner join sys.schemas s
	on p.schema_id = s.schema_id
	where 
			s.name	= 'Insights'
		and p.name = 'uspInsights_Archive'
	) IS NOT NULL
	DROP PROC Insights.uspInsights_Archive;
GO

CREATE PROC Insights.uspInsights_Archive
AS
BEGIN
		BEGIN TRANSACTION

		--remove the Campaign object identifier
		UPDATE insights.Insights_Import SET data_ = REPLACE(data_,'<AdsInsights>', '')
		
		UPDATE ao
		set islatest = 0
		--SELECT *
		FROM.Insights.Insights_Archive ao
			INNER JOIN 
			(
				SELECT CampaignId, insightDateTimeUTC, data_ FROM insights.Insights_Import 
				EXCEPT
				SELECT CampaignId, insightDateTimeUTC, data_ FROM Insights.Insights_Archive WHERE isLatest = 1
			) u
			on ao.CampaignId = u.CampaignId and ao.insightDateTimeUTC = u.insightDateTimeUTC
			--SELECT * FROM insights.Insights_Import 
		--Insert the updated row
		INSERT INTO Insights.Insights_Archive
		SELECT 
			CampaignId, insightDateTimeUTC, importDateTimeUTC, data_, isLatest

		FROM 
		(
			SELECT 
				 ROW_NUMBER() OVER(PARTITION BY upd.CampaignId, upd.insightDateTimeUTC ORDER by PKID Desc) row_ 
				,upd.CampaignId
				,upd.insightDateTimeUTC
				,upd.importDateTimeUTC
				,upd.data_
				,1 isLatest
			
			FROM insights.Insights_Import upd
			INNER JOIN
			(
				SELECT CampaignId, insightDateTimeUTC, data_ FROM insights.Insights_Import 
				EXCEPT
				SELECT CampaignId, insightDateTimeUTC, data_ FROM Insights.Insights_Archive WHERE isLatest = 1
				
			) U
				on upd.CampaignId = U.CampaignId and upd.insightDateTimeUTC = u.insightDateTimeUTC
		) U WHERE row_ = 1


		COMMIT TRANSACTION
END
