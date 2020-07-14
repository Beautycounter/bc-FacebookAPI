from facebook_business.adobjects.adaccount import AdAccount
from facebook_business.adobjects.campaign import Campaign
from facebook_business.api import FacebookAdsApi
from datetime import datetime
from facebook_business.adobjects.adreportrun import AdReportRun
import _SQLInterface
import json
import time

class _FacebookInterface(object):
    """
    Creates extract from the various APIs
    """
    def getCampaigns(clientID, clientSecret, access_token, accountId):
        
        fields = [
            'account_id'
            ,'adlabels'
            ,'buying_type'
            ,'configured_status'
            ,'effective_status'
            ,'id'
            ,'is_completed'
            ,'name'
            ,'objective'
            ,'promoted_object'
            ,'spend_cap'
            ,'start_time'
            ,'stop_time'
            ,'updated_time'
            ]

        #get all camps for all time
        params = {
            
            }

        try:
            FacebookAdsApi.init(access_token=access_token)
            sqlConnectionString = 'Driver={SQL Server};SERVER=datamart-dev.beautycounter.com;Database=facebook;UID=dataworker;PWD=dataworker1'
                
            for campaign in AdAccount(accountId).get_campaigns(fields=fields):                
                SQL = "INSERT into staging.campaigns_import SELECT '" + campaign._data['id'] +"', '" + campaign._data['start_time'] + "', '" + campaign._data['updated_time'] + "', '"  + datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3] + 'Z' + "', '" + campaign._data['effective_status'] + "', '" + str(campaign) + "'"
                _SQLInterface._SQLInterface.insertRows(sqlConnectionString, SQL)

            return 'Campaigns Done'
            pass
        except ValueError:
            return 'error' + ValueError
 
    def getInsights(clientID, clientSecret, access_token, campaignId, startDate, endDate):
        
        params = {
            'time_increment':1
            ,'level':'campaign'
            ,'time_range':{'since':startDate,'until':endDate}
           }
        
        fields = [
            'campaign_id'
            ,'campaign_name'
            ,'adset_id'
            ,'adset_name'
            ,'ad_id'
            ,'ad_name'
            ,'date_start'
            ,'unique_inline_link_click_ctr'
            ,'clicks'
            ,'impressions'
            ,'objective'
            ,'reach'
            ,'spend'
            ,'cpc'
            ,'ctr'
            ,'labels'
            ,'objective'
            ]

        try:
            FacebookAdsApi.init(access_token=access_token)
            c = Campaign(campaignId)

            sqlConnectionString = 'Driver={SQL Server};SERVER=datamart-dev.beautycounter.com;Database=facebook;UID=dataworker;PWD=dataworker1'
            for insight in c.get_insights(params=params,fields=fields):
                SQL = "INSERT into staging.insights_import SELECT '"+ insight._data['campaign_id'] + "', '" + insight._data['date_start']+ "', '"+ datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3] + 'Z' +"', '" + str(insight) + "'"
                print(SQL)
                _SQLInterface._SQLInterface.insertRows(sqlConnectionString, SQL)
            
            return 'Insight Pull Done'
        
        except ValueError:
            return 'error' + ValueError
        