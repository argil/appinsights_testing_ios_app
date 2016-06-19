//
//  ViewController.m
//  testing_ios_app
//
//  Created by argil on 6/18/16.
//
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *m_textView;

@end

@implementation ViewController

- (void)receiveTestNotification:(NSNotification*)notification
{
	NSMutableString *mutableString = [NSMutableString stringWithFormat:@"%@", [[self m_textView] text]];
	[mutableString appendString:[notification object]];
	[[self m_textView] setText:mutableString];
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(receiveTestNotification:)
												 name:kRemoteLog
											   object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
#pragma unused(animated)
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

@end
