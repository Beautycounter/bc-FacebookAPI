use [facebook]

DELETE API.facebookParameters WHERE BQType IN ('API', 'API_CA')

INSERT API.facebookParameters
select 'API', 'app_id', '3139641912761065'
UNION
select 'API', 'app_secret', 'aa247ebe0bf724f3b395db626e368515'
UNION
select 'API', 'access_token', 'EAAsnfNjumukBAPKDzu1sE2Xs9WZBIIu1HGMQpHYizOzaIlFlLUyJDdiJ0IpVqhG2oYqEVWembJURnMjUXSGstWwSgC5Y6rYx8rogfLJF3MfZCNssZAZCCoyCtk4QugZAPiBOSTxMCqtiLwXrMyESPPNyDxio5RzcVZC9MffvG9jNkVAbXZBWeGZC'
UNION
select 'API', 'account_id', 'act_1911651192179072'
UNION
select 'API', 'SQLConnectionString', 'SERVER=localhost;Database=facebook;UID=dataworker;PWD=dataworker1' 

--SELECT * FROM API.facebookParameters WHERE bqtype = 'API'
