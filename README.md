# Testing the App Insights SDK
```msftappinsights_testing_ios_app``` is a simple app I built to test out the [App Insights SDK](https://github.com/Microsoft/ApplicationInsights-iOS)

# Preview

![Preview1](https://argil.github.io/appinsights_testing_ios_app/screenshot.png)

# Get telemetry reports

Go to the [Azure Portal](https://portal.azure.com), select your app instance (in my case ```msftappinsights_testing_ios_app```), and then click ```Analytics```.

To get the last messages sent from the app:
```script
traces | take 15
```

To get the top 10 custom events:
```script
customEvents | where timestamp >= ago(7d)| summarize dcount(user_Id), count() by name| top 10 by count_ | render piechart
```
