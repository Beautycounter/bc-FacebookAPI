USE MailChimp

TRUNCATE TABLE API.CmdshellExecutions 

INSERT API.CmdshellExecutions

SELECT 'GetCampaigns', '#insert .bet exe#'
	, '"GetCampaigns" "SERVER=localhost;Database=MailChimp;UID=dataworker;PWD=dataworker1" "Campaigns.uspGetCampaignsParameters"'
