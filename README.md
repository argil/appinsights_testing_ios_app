# msftappinsights_testing_ios_app
Testing the App Insights SDK

# Get telemetry reports

Go to (https://portal.azure.com), select ```msftappinsights_testing_ios_app```, and then click ```Analytics```.

To get the last messages sent from the app:
```script
traces | take 15
```

To get the top 10 custom events:
```script
customEvents | where timestamp >= ago(7d)| summarize dcount(user_Id), count() by name| top 10 by count_ | render piechart
```
