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
#sqlConnectionString = sys.argv[5]
#exec = sys.argv[6]

app_id = '3139641912761065'
app_secret = 'aa247ebe0bf724f3b395db626e368515'
access_token = 'EAAsnfNjumukBAPKDzu1sE2Xs9WZBIIu1HGMQpHYizOzaIlFlLUyJDdiJ0IpVqhG2oYqEVWembJURnMjUXSGstWwSgC5Y6rYx8rogfLJF3MfZCNssZAZCCoyCtk4QugZAPiBOSTxMCqtiLwXrMyESPPNyDxio5RzcVZC9MffvG9jNkVAbXZBWeGZC' # Your user access token
id = 'act_1911651192179072'
sqlConnectionString = 'Driver={SQL Server};SERVER=datamart-dev.beautycounter.com;Database=facebook;UID=dataworker;PWD=dataworker1'
exec = ''


if exec == 'Campaigns':
    (_FacebookInterface._FacebookInterface.getCampaigns(app_id, app_secret, access_token, id))
    pass

if exec == 'Insights':
    SQLdata = _SQLInterface._SQLInterface.getResultSet(sqlConnectionString,SQL)
    for x in SQLdata.iterrows():
        print(x[1][0])
        (_FacebookInterface._FacebookInterface.getInsights(app_id, app_secret, access_token, x[1][0], x[1][2], x[1][3]))
        pass
    pass

print("All Done")

