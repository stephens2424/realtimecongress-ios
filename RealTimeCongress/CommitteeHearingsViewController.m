//
//  CommitteeHearingsViewController.m
//  RealTimeCongress
//
//  Created by Tom Tsai on 5/25/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "CommitteeHearingsViewController.h"
#import "JSONKit.h"

#pragma mark Utility extensions

@interface UILabel (sizingExtensions)
- (void)sizeToFitFixedWidth:(NSInteger)fixedWidth;
@end

@implementation UILabel (sizingExtensions)


- (void)sizeToFitFixedWidth:(NSInteger)fixedWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
    self.lineBreakMode = UILineBreakModeWordWrap;
    self.numberOfLines = 0;
    [self sizeToFit];
}
@end

@implementation CommitteeHearingsViewController

@synthesize parsedHearingData;
@synthesize items;
@synthesize jsonData;
@synthesize jsonKitDecoder;
@synthesize chamberControl;
@synthesize hearingEnumerator;
@synthesize allHearings;
@synthesize loadingIndicator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [loadingIndicator release];
    [chamberControl release];
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
    self.title = @"Hearings";
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self  action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    // Refreshes table view data on segmented control press;
    [chamberControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    // JSONKit requests
    //Request data based on segemented control at launch
    [self refresh];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (parsedHearingData != NULL) {
        return [parsedHearingData count];
    }
    else{
        return 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a custom cell for each entry. Set the height according to string length or autosize.
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text                      = [[[parsedHearingData objectAtIndex:indexPath.row] 
                                                objectForKey:@"committee"] objectForKey:@"name"];
    cell.detailTextLabel.text                = [[parsedHearingData objectAtIndex:indexPath.row] 
                                                objectForKey:@"legislative_day"];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark - UI Actions
- (void) refresh
{
    // JSONKit requests
    //Request data based on segemented control selection
    //Hide the table view and animate the activity indicator when loading data
    self.view.hidden = YES;
    [loadingIndicator startAnimating];
    if (chamberControl.selectedSegmentIndex == 0) {
        jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:HOUSE_URL]];
    }
    else {
        jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:SENATE_URL]];
    }
    if (jsonData != NULL) {
        [self parseData];
    }
    [self.tableView reloadData];
    //Hide the activity indicator and reveal the table view once loading is complete
    [loadingIndicator stopAnimating];
    self.view.hidden = NO;
}

- (void) parseData
{
    jsonKitDecoder = [JSONDecoder decoder];
    items = [jsonKitDecoder objectWithData:jsonData];
    NSArray *data = [items objectForKey:@"committee_hearings"];
    //parsedHearingData = [[NSArray alloc] initWithArray:data];
    //Sort data by legislative day
    NSSortDescriptor *sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"legislative_day" ascending:YES];
    NSArray *descriptors = [[NSArray alloc] initWithObjects: sortByDate, nil];
    parsedHearingData = [[NSArray alloc] initWithArray:[data sortedArrayUsingDescriptors:descriptors]];
    
}

@end
