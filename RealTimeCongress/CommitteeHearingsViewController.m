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
@synthesize opQueue;
@synthesize committeeHearingsCell;

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
    [opQueue release];
    [parsedHearingData release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    [parsedHearingData release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self  action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    //Make cells unselectable
    self.tableView.allowsSelection = NO;
    
    //Initialize the operation queue
    opQueue = [[NSOperationQueue alloc] init];
    
    // Refreshes table view data on segmented control press;
    [chamberControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    //An activity indicator to indicate loading
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingIndicator setCenter:self.view.center];
    [self.view addSubview:loadingIndicator];
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
    //Refresh data
    [self refresh];
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
        [[NSBundle mainBundle] loadNibNamed:@"CommitteeHearingsCell" owner:self options:nil];
        cell = committeeHearingsCell;
        self.committeeHearingsCell = nil;
    }
    //Calculate the correct size for each UILabel
    UILabel *committeeNameLabel;
    UILabel *timeAndPlaceLabel;
    UILabel *descriptionLabel;
    
    //Position Committee Name text
    committeeNameLabel = (UILabel *)[cell viewWithTag:1];
    committeeNameLabel.text = [[[parsedHearingData objectAtIndex:indexPath.row] 
                   objectForKey:@"committee"] objectForKey:@"name"];
    [committeeNameLabel sizeToFitFixedWidth:320];
    
    //Position Time and Place text
    timeAndPlaceLabel = (UILabel *)[cell viewWithTag:2];
    if (parsedHearingData != NULL) {
        if (chamberControl.selectedSegmentIndex == 0) {
            timeAndPlaceLabel.text = [NSString stringWithFormat:@"%@", 
                                      [[parsedHearingData objectAtIndex:indexPath.row] 
                                        objectForKey:@"time_of_day"]];
        }
        else {
            timeAndPlaceLabel.text = [NSString stringWithFormat:@"%@ (%@)", 
                                      [[parsedHearingData objectAtIndex:indexPath.row] objectForKey:@"time_of_day"], [[parsedHearingData objectAtIndex:indexPath.row] objectForKey:@"room"]];
        }
    }
    timeAndPlaceLabel.frame = CGRectMake(committeeNameLabel.frame.origin.x, 
                                         (committeeNameLabel.frame.origin.y + committeeNameLabel.frame.size.height),320, 0);
    [timeAndPlaceLabel sizeToFitFixedWidth:320];
    
    //Position Description text
    descriptionLabel = (UILabel *)[cell viewWithTag:3];
    descriptionLabel.text = [[parsedHearingData objectAtIndex:indexPath.row] objectForKey:@"description"];
    descriptionLabel.frame = CGRectMake(committeeNameLabel.frame.origin.x, 
                                        (timeAndPlaceLabel.frame.origin.y + timeAndPlaceLabel.frame.size.height), 
                                        320, 0);
    [descriptionLabel sizeToFitFixedWidth:320];
    
    return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Calculates the appropriate row height based on the size of the three text labels
    CGSize maxSize = CGSizeMake(320, CGFLOAT_MAX);
    
    CGSize committeeNameTextSize = [[[[parsedHearingData objectAtIndex:indexPath.row] objectForKey:@"committee"] objectForKey:@"name"] sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:maxSize];
    
    CGSize timeAndPlaceTextSize;
    if (chamberControl.selectedSegmentIndex == 0) {
        timeAndPlaceTextSize = [[NSString stringWithFormat:@"%@", 
                                 [[parsedHearingData objectAtIndex:indexPath.row] 
                                  objectForKey:@"time_of_day"]] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:maxSize];
    }
    else {
        timeAndPlaceTextSize = [[NSString stringWithFormat:@"%@ (%@)", 
                                 [[parsedHearingData objectAtIndex:indexPath.row] objectForKey:@"time_of_day"], [[parsedHearingData objectAtIndex:indexPath.row] objectForKey:@"room"]] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:maxSize];
    }
    
    CGSize descriptionTextSize = [[[parsedHearingData objectAtIndex:indexPath.row] objectForKey:@"description"] sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:maxSize];
    
    return (committeeNameTextSize.height + timeAndPlaceTextSize.height + descriptionTextSize.height + 5);
}

#pragma mark - UI Actions
- (void) refresh
{
    //Set the navigation bar title to that of the selected chamber
    self.title = [NSString stringWithFormat:@"%@ Hearings", [chamberControl titleForSegmentAtIndex:chamberControl.selectedSegmentIndex]];
    
    //Animate the activity indicator when loading data
    [self.loadingIndicator startAnimating];
    
    //Asynchronously retrieve data
    NSInvocationOperation* dataRetrievalOp = [[[NSInvocationOperation alloc] initWithTarget:self
                                                                                   selector:@selector(retrieveData) object:nil] autorelease];
    [dataRetrievalOp addObserver:self forKeyPath:@"isFinished" options:0 context:NULL];
    [opQueue addOperation:dataRetrievalOp];
}

- (void) parseData
{
    jsonKitDecoder = [JSONDecoder decoder];
    items = [jsonKitDecoder objectWithData:jsonData];
    NSArray *data = [items objectForKey:@"committee_hearings"];

    //Sort data by legislative day
    NSSortDescriptor *sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"legislative_day" ascending:YES];
    NSArray *descriptors = [[NSArray alloc] initWithObjects: sortByDate, nil];
    parsedHearingData = [[NSArray alloc] initWithArray:[data sortedArrayUsingDescriptors:descriptors]];
    
}

- (void) retrieveData
{
    //JSONKit requests
    //Request data based on segemented control selection
    if (chamberControl.selectedSegmentIndex == 0) {
        jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:HOUSE_URL]];
    }
    else {
        jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:SENATE_URL]];
    }
    if (jsonData != NULL) {
        [self parseData];
    }
}

#pragma mark Key-Value Observing methods
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqual:@"isFinished"]) {
        //Reload the table once data retrieval is complete
        [self.tableView reloadData];
            
        //Hide the activity indicator once loading is complete
        [loadingIndicator stopAnimating];
    }
}

@end
