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

-(void)handleLog:(NSNotification*)notification
{
	NSFileHandle* pipeReadHandle = [notification object];
	[pipeReadHandle readInBackgroundAndNotify] ;
	NSString *log = [[NSString alloc] initWithData:[[notification userInfo] objectForKey: NSFileHandleNotificationDataItem]
										  encoding: NSASCIIStringEncoding] ;

	// Post notification with log string.
	[[NSNotificationCenter defaultCenter] postNotificationName:kRemoteLog object:log];
}

- (void)redirectStderrToPipe
{
	NSPipe *pipe = [NSPipe pipe];
	NSFileHandle* fileHandleForReading = [pipe fileHandleForReading];
	dup2([[pipe fileHandleForWriting] fileDescriptor], fileno(stderr)) ;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLog:)
												 name:NSFileHandleReadCompletionNotification
											   object:fileHandleForReading];
	[fileHandleForReading readInBackgroundAndNotify];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self redirectStderrToPipe];

	[MSAIApplicationInsights setup];
	[[MSAIApplicationInsights sharedInstance] setDebugLogEnabled:YES];
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
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
