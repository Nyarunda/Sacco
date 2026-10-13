
// Web Service Setup Instructions (Comments)
/*
To set up the web service in D365 BC:

1. Go to "Web Services" page in Business Central
2. Create a new web service with:
   - Object Type: Page
   - Object ID: 50100
   - Service Name: TransactionLogAPI
   - Published: Yes

3. The API endpoint will be available at:
   https://[your-bc-server]/[tenant]/api/[publisher]/[apigroup]/[version]/[entitysetname]
   
   Example:
   https://your-bc-server.com/BC/api/YourCompany/TransactionAPI/v1.0/transactionLogs
   http://213.136.83.37:7047/BC252/api/Wanandege%20Sacco/TransactionAPI/v1.0/transactionLogs
   https://nav.contoso.com:7048/bc/api/v2.0

4. Authentication:
   - Use OAuth 2.0 or Basic Authentication
   - Set up proper permissions for the user account

5. To call the API from your FastAPI application:
   POST https://your-bc-server.com/BC/api/YourCompany/TransactionAPI/v1.0/transactionLogs
   Headers:
   - Content-Type: application/json
   - Authorization: Bearer [token] or Basic [credentials]

6. Sample POST request body structure:
   {
       "serviceName": "FT",
       "messageID": "test_004",
       "connectionID": "masked_connection_id",
       "transactionDate": "2018-02-09T00:00:00",
       "terminalID": "43",
       "channel": "OMNICHANNEL",
       "transactionType": "0003",
       "institutionCode": "42993301",
       "institutionName": "KENYA POLICE SACCO",
       "debitAccount": "sacco_12345",
       "amount": 2000,
       "currency": "404",
       "creditAccount": "9876774",
       "chargeAmount": 20,
       "chargeCurrency": "404",
       "feeAmount": 20,
       "feeCurrency": "404",
       "narrative1": "Funds Transfer for account sacco_12345",
       "narrative2": ""
   }
*/