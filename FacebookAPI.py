from facebook_business.adobjects.adaccount import AdAccount
from facebook_business.adobjects.campaign import Campaign
from facebook_business.api import FacebookAdsApi
import _FacebookInterface
import _SQLInterface
import pandas
import json
import sys
from datetime import datetime


argumentList = sys.argv
print(argumentList)

#app_id = sys.argv[1]
#app_secret = sys.argv[2]
#access_token = sys.argv[3]
#id = sys.argv[4]

app_id = '3139641912761065'
app_secret = 'aa247ebe0bf724f3b395db626e368515'
access_token = 'EAAsnfNjumukBAPKDzu1sE2Xs9WZBIIu1HGMQpHYizOzaIlFlLUyJDdiJ0IpVqhG2oYqEVWembJURnMjUXSGstWwSgC5Y6rYx8rogfLJF3MfZCNssZAZCCoyCtk4QugZAPiBOSTxMCqtiLwXrMyESPPNyDxio5RzcVZC9MffvG9jNkVAbXZBWeGZC' # Your user access token
id = 'act_1911651192179072'

#'23844861053750291'
sqlConnectionString = 'Driver={SQL Server};SERVER=datamart-dev.beautycounter.com;Database=facebook;UID=dataworker;PWD=dataworker1'
#SQL = 'select 1 num'
#(_FacebookInterface._FacebookInterface.getCampaigns(app_id, app_secret, access_token, id))
(_FacebookInterface._FacebookInterface.getInsights(app_id, app_secret, access_token, '23843162892500291', '2019-03-14','2020-07-13'))

#(_FacebookInterface._FacebookInterface.getInsights(app_id, app_secret, access_token, '23844932974050291', 0))
print("All Done")

#SQL = 'select 1 num into dbo.TestTable'
#_SQLInterface._SQLInterface.insertRows(sqlConnectionString, SQL)
#print(SQLdata)


#FacebookAdsApi.init(access_token=access_token)
#
#params = {
#    'time_range':{'since':'2020-07-08','until':'2020-07-13'}
#    ,'time_increment':1
#    }
#
#fields = [
#    'insights'
#    ]
#
#a = AdAccount(id).get_ad_sets(params=params,fields=fields)
#b = AdAccount(id).get_ads(params=params,fields=fields)
#print(a)
#print(b)


#SQLdata = _SQLInterface._SQLInterface.getResultSet(sqlConnectionString,SQL)
#print(SQLdata)

#SQL = 'select 1 num into dbo.TestTable'
#_SQLInterface._SQLInterface.insertRows(sqlConnectionString, SQL)
#print(SQLdata)
