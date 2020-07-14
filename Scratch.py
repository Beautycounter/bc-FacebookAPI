import numpy as np
import pandas as pd
from  multiprocessing import Pool
import time 
import _SQLInterface


SQL = "select c.campaignId, c.campaignStatus, MAX(ISNULL(i.insightDateTimeUTC,CAST(c.startDateTimeUTC AS DATE))) startDate from campaigns.campaigns_archive c left outer join Insights.insights_archive i on c.campaignId = i.campaignId group by c.campaignId, c.campaignStatus"
#print(SQL)

sqlConnectionString = 'Driver={SQL Server};SERVER=datamart-dev.beautycounter.com;Database=facebook;UID=dataworker;PWD=dataworker1'
SQLdata = _SQLInterface._SQLInterface.getResultSet(sqlConnectionString,SQL)
#print(SQLdata)
   
for x in SQLdata.iterrows():
    print(x[1][0])
    print(x[1][1])
    print(x[1][2])


print('Done')


