//
//  AboutViewController.m
//  RealTimeCongress
//
//  Created by Tom Tsai on 5/24/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [webView release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"About";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AboutInfo" ofType:@"html"];
    NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    
    NSString *htmlString = [[NSString alloc] initWithData: 
                            [readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [htmlString release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
