
use facebook

IF (SELECT TOP 1 1 
	FROM sys.procedures p 
	inner join sys.schemas s
	on p.schema_id = s.schema_id
	where 
			s.name	= 'Campaigns'
		and p.name = 'uspCampaigns_Archive'
	) IS NOT NULL
	DROP PROC Campaigns.uspCampaigns_Archive;
GO

CREATE PROC Campaigns.uspCampaigns_Archive
AS
BEGIN
		BEGIN TRANSACTION

		--remove the Campaign object identifier
		UPDATE staging.Campaigns_Import SET data_ = REPLACE(data_,'<Campaign>', '')

		UPDATE ao
		set islatest = 0
		--SELECT *
		FROM.Campaigns.Campaigns_Archive ao
			INNER JOIN 
			(

				SELECT 
					 campaignId
					,CAST(SUBSTRING(REPLACE(startDateTimeUTC,'T',' '),1,19) + ' ' + SUBSTRING(startDateTimeUTC,20,3) 
						+ ':' + SUBSTRING(startDateTimeUTC,23,2) AS datetimeoffset(0)) AT TIME ZONE 'UTC' startDateTimeUTC
					,CAST(SUBSTRING(REPLACE(updateDateTimeUTC,'T',' '),1,19) + ' ' + SUBSTRING(updateDateTimeUTC,20,3) 
						+ ':' + SUBSTRING(updateDateTimeUTC,23,2) AS datetimeoffset(0)) AT TIME ZONE 'UTC' updateDateTimeUTC
				FROM staging.Campaigns_Import 
				EXCEPT
				SELECT  CampaignId, startDateTimeUTC,updateDateTimeUTC FROM Campaigns.Campaigns_Archive WHERE isLatest = 1
			) u
			on ao.CampaignId = u.CampaignId
			--SELECT * FROM staging.Campaigns_Import 
		--Insert the updated row
		INSERT INTO Campaigns.Campaigns_Archive
		SELECT 
			CampaignId, startDateTimeUTC, updateDateTimeUTC, importDateTimeUTC, campaignStatus, data_, isLatest

		FROM 
		(
			SELECT 
				 ROW_NUMBER() OVER(PARTITION BY upd.CampaignId ORDER by PKID Desc) row_ 
				,upd.CampaignId
				,CAST(SUBSTRING(REPLACE(upd.startDateTimeUTC,'T',' '),1,19) + ' ' + SUBSTRING(upd.startDateTimeUTC,20,3) 
						+ ':' + SUBSTRING(upd.startDateTimeUTC,23,2) AS datetimeoffset(0)) AT TIME ZONE 'UTC' startDateTimeUTC
					,CAST(SUBSTRING(REPLACE(upd.updateDateTimeUTC,'T',' '),1,19) + ' ' + SUBSTRING(upd.updateDateTimeUTC,20,3) 
						+ ':' + SUBSTRING(upd.updateDateTimeUTC,23,2) AS datetimeoffset(0)) AT TIME ZONE 'UTC' updateDateTimeUTC
				,importDateTimeUTC
				,upd.campaignStatus
				,upd.data_
				,1 isLatest
			
			FROM staging.Campaigns_Import upd
			INNER JOIN
			(
				SELECT 
					 campaignId
					,CAST(SUBSTRING(REPLACE(startDateTimeUTC,'T',' '),1,19) + ' ' + SUBSTRING(startDateTimeUTC,20,3) 
						+ ':' + SUBSTRING(startDateTimeUTC,23,2) AS datetimeoffset(0)) AT TIME ZONE 'UTC' startDateTimeUTC
					,CAST(SUBSTRING(REPLACE(updateDateTimeUTC,'T',' '),1,19) + ' ' + SUBSTRING(updateDateTimeUTC,20,3) 
						+ ':' + SUBSTRING(updateDateTimeUTC,23,2) AS datetimeoffset(0)) AT TIME ZONE 'UTC' updateDateTimeUTC
				FROM staging.Campaigns_Import 
				EXCEPT
				SELECT  CampaignId, startDateTimeUTC,updateDateTimeUTC FROM Campaigns.Campaigns_Archive WHERE isLatest = 1
			) U
				on upd.CampaignId = U.CampaignId
		) U WHERE row_ = 1


		COMMIT TRANSACTION
END
