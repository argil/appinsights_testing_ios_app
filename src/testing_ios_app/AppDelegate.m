//
//  AppDelegate.m
//  testing_ios_app
//
//  Created by argil on 6/18/16.
//
//

#import "AppDelegate.h"

@import ApplicationInsights;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[MSAIApplicationInsights setup];
#if DEBUG
	[[MSAIApplicationInsights sharedInstance] setDebugLogEnabled:YES];
#endif // DEBUG
	[MSAIApplicationInsights start];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	[MSAITelemetryManager trackTraceWithMessage:@"Test applicationWillResignActive"];}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[MSAITelemetryManager trackTraceWithMessage:@"Test applicationDidEnterBackground"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	[MSAITelemetryManager trackTraceWithMessage:@"Test applicationWillEnterForeground"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	[MSAITelemetryManager trackEventWithName:@"Custom event"
								  properties:@{@"Test property 1":@"Some test value",
											   @"Test property 2":@"Some other test value"}
								measurements:@{@"Test measurement 1":@(4.8),
											   @"Test measurement 2":@(15.16),
											   @"Test measurement 3":@(23.42)}];

	[MSAITelemetryManager trackTraceWithMessage:@"Test applicationDidBecomeActive"];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[MSAITelemetryManager trackTraceWithMessage:@"Test applicationWillTerminate"];
}

@end
