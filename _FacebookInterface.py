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
    Creates extract from the various API s
    """
    def getCampaigns(clientID, clientSecret, access_token, accountId):
        
        FacebookAdsApi.init(access_token=access_token)

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

        sqlConnectionString = 'Driver={SQL Server};SERVER=datamart-dev.beautycounter.com;Database=facebook;UID=dataworker;PWD=dataworker1'
            
        for campaign in AdAccount(accountId).get_campaigns(fields=fields):
            SQL = "INSERT into staging.ad_imports SELECT '"+ datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3] + 'Z' +"', '" + str(campaign) + "'"
            print(SQL)
            _SQLInterface._SQLInterface.insertRows(sqlConnectionString, SQL)

        return 'Campaigns Done'
        #print (Campaigns)
        
    def getInsights(clientID, clientSecret, access_token, campaignId, timePull):
        
        FacebookAdsApi.init(access_token=access_token)

        def dateSwitch(timePull):
                switcher={
                    0: Campaign.DatePreset.yesterday
                    ,1: Campaign.DatePreset.last_7d
                    ,2: Campaign.DatePreset.last_14d
                    } 
                return switcher
        
        params = {
            #'date_preset': Campaign.DatePreset.last_7d
            'time_increment':1
            ,'level':'campaign'
            ,'time_range':{'since':'2020-07-10','until':'2020-07-10'}
           }
        

        fields = [
            'campaign_id'
            ,'campaign_name'
            ,'adset_id'
            ,'adset_name'
            ,'ad_id'
            ,'ad_name'
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

        c = Campaign(campaignId)

        sqlConnectionString = 'Driver={SQL Server};SERVER=datamart-dev.beautycounter.com;Database=facebook;UID=dataworker;PWD=dataworker1'
        for insight in c.get_insights(params=params,fields=fields):
            SQL = "INSERT into staging.ad_imports SELECT '"+ datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S.%f')[:-3] + 'Z' +"', '" + str(insight) + "'"
            print(SQL)
            _SQLInterface._SQLInterface.insertRows(sqlConnectionString, SQL)
        
        return 'Insights Done'
        