from facebook_business.adobjects.adaccount import AdAccount
from facebook_business.adobjects.campaign import Campaign
from facebook_business.api import FacebookAdsApi
import pyodbc
import _FacebookInterface
import json
import sys
import pandas

class _SQLInterface(object):
    """
    SQL Server Interface for the Facebook API
    """
    def getResultSet(sqlConnectionString, SQL):

        conn = pyodbc.connect(sqlConnectionString)

        return(pandas.read_sql_query(SQL,conn))
        

    def insertRows(sqlConnectionString, dataFrame):
        
        try:
            conn = pyodbc.connect(sqlConnectionString)
            
            cursor = conn.cursor()
            cursor.execute(dataFrame)
            conn.commit()

            return 'Successfully inserted data'
        
        except ValueError:
            return 'error' + ValueError
        

