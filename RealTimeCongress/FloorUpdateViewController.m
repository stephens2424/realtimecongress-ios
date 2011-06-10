//
//  FloorUpdateViewController.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "FloorUpdateViewController.h"
#import "FloorUpdate.h"
#import "SunlightLabsRequest.h"

@implementation FloorUpdateViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)receiveFloorUpdate:(NSNotification *)notification {
    [connection release];
    NSDictionary * userInfo = [notification userInfo];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    NSMutableArray * tempFloorUpdates = [NSMutableArray arrayWithCapacity:20];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSMutableString * floorUpdateText = [NSMutableString stringWithCapacity:100];
    for (id update in [userInfo objectForKey:@"floor_updates"]) {
        NSDate * date = [dateFormatter dateFromString:[update objectForKey:@"timestamp"]];
        for (id str in [update objectForKey:@"events"]) {
            str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            [floorUpdateText appendFormat:@"%@",str];
        }
        FloorUpdate * floorUpdate = [[[FloorUpdate alloc] initWithDisplayText:floorUpdateText atDate:date] autorelease];
        for (id str in [update objectForKey:@"legislator_ids"]) {
            Legislator * legislator = [[[Legislator alloc] initWithBioguideId:str] autorelease];
            [legislator requestInformation];
            [floorUpdate addLegislator:legislator];
        }
        //TODO add bill and roll call references.
        [tempFloorUpdates addObject:floorUpdate];
        [floorUpdateText setString:@""];
    }
    id last = [[floorUpdates lastObject] retain];
    [floorUpdates removeObject:[floorUpdates lastObject]];
    [floorUpdates addObjectsFromArray:tempFloorUpdates];
    [floorUpdates addObject:last];
    [last release];
    [self.tableView reloadData];
}

- (void)refresh {
    page = 0;
    [floorUpdates removeAllObjects];
    [rotatedCellIndexes removeAllObjects];
    [floorUpdates addObject:@"LoadingRow"];
    [self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"Floor Updates";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.navigationController.toolbarHidden = NO;
    control = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Senate",@"House",nil]];
    [control setSelectedSegmentIndex:0];
    [control addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    [self setToolbarItems:[NSArray arrayWithObjects:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL] autorelease],[[[UIBarButtonItem alloc] initWithCustomView:control] autorelease],[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL] autorelease],nil]];
    page = 0;
    floorUpdates = [[NSMutableArray alloc] initWithCapacity:20];
    [floorUpdates addObject:@"LoadingRow"];
    rotatedCellIndexes = [[NSMutableArray alloc] initWithCapacity:3];
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
    [control release];
    [floorUpdates release];
    [rotatedCellIndexes release];
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
    return [floorUpdates count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[floorUpdates objectAtIndex:indexPath.row] isMemberOfClass:[FloorUpdate class]]) {
        return [[floorUpdates objectAtIndex:indexPath.row] textHeight] + 55; //55 = the height of the table cell wihtout the event text (76 - 21)
    } else {
        return 44.0;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [floorUpdates indexOfObject:[floorUpdates lastObject]]) {
        page += 1;
        NSString * chamber = [control selectedSegmentIndex] == 0 ? @"senate" : @"house";
        connection = [[SunlightLabsConnection alloc] initWithSunlightLabsRequest:[[[SunlightLabsRequest alloc] initFloorUpdateRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ul",page],@"page",chamber,@"chamber", nil]] autorelease]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFloorUpdate:) name:SunglightLabsRequestFinishedNotification object:connection];
        [connection sendRequest];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[floorUpdates objectAtIndex:indexPath.row] isMemberOfClass:[FloorUpdate class]]) {
        static NSString *CellIdentifier = @"FloorUpdateCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FloorUpdateTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        [(UILabel *)[cell viewWithTag:1] setText:[[floorUpdates objectAtIndex:indexPath.row] displayDate]];
        [(UITextView *)[cell viewWithTag:2] setFrame:CGRectMake([cell viewWithTag:2].frame.origin.x, [cell viewWithTag:2].frame.origin.y, [cell viewWithTag:2].frame.size.width,[[floorUpdates objectAtIndex:indexPath.row] textViewHeightRequired])];
        [(UITextView *)[cell viewWithTag:2] setText:[[floorUpdates objectAtIndex:indexPath.row] displayText]];
        if ([[floorUpdates objectAtIndex:indexPath.row] hasAbbreviations]) {
            ((UIView *)[cell viewWithTag:3]).hidden = NO;
            if ([rotatedCellIndexes containsObject:indexPath])
                ((UIView *)[cell viewWithTag:3]).transform = CGAffineTransformMakeRotation( ( 180 * M_PI ) / 180 );
        }
        return cell;
    } else if ([[floorUpdates objectAtIndex:indexPath.row] isMemberOfClass:[Legislator class]]) {
        static NSString *CellIdentifier = @"AbbreviatedLegislatorCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AbbreviatedLegislatorTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        [(UILabel *)[cell viewWithTag:1] setText:[NSString stringWithFormat:@"%@ %@",[[floorUpdates objectAtIndex:indexPath.row] fullName],[[floorUpdates objectAtIndex:indexPath.row] parentheticalSeat]]];
        return cell;
    } else if ([[floorUpdates objectAtIndex:indexPath.row] isMemberOfClass:[Bill class]]) {
        static NSString *CellIdentifier = @"AbbreviatedBillCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AbbreviatedBillTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        [(UILabel *)[cell viewWithTag:1] setText:[[floorUpdates objectAtIndex:indexPath.row] shortTitle]];
        return cell;
    } else if ([[floorUpdates objectAtIndex:indexPath.row] isEqual:@"LoadingRow"]) {
        static NSString *CellIdentifier = @"LoadingCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LoadingTableViewCell" owner:self options:nil] objectAtIndex:0];
        }
        return cell;
    } else {
        static NSString * cellIdentifier = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![[floorUpdates objectAtIndex:indexPath.row] isMemberOfClass:[FloorUpdate class]]) {
        return;
    }
    UIView * button = [[tableView cellForRowAtIndexPath:indexPath] viewWithTag:3];
    [CATransaction begin];
    [tableView beginUpdates];
    if (![rotatedCellIndexes containsObject:indexPath]) {
        CABasicAnimation *halfTurn;
        halfTurn = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        halfTurn.fromValue = [NSNumber numberWithFloat:0];
        halfTurn.toValue = [NSNumber numberWithFloat:((180*M_PI)/180)];
        halfTurn.duration = 0.25;
        halfTurn.repeatCount = 1;
        [button.layer addAnimation:halfTurn forKey:@"180"];
        button.transform = CGAffineTransformMakeRotation( ( 180 * M_PI ) / 180 );
        [rotatedCellIndexes addObject:indexPath];
        [tableView insertRowsAtIndexPaths:[self addDetailDataAndCreateIndexPaths:[floorUpdates objectAtIndex:indexPath.row] origin:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    } else {
        CABasicAnimation *halfTurn;
        halfTurn = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        halfTurn.fromValue = [NSNumber numberWithFloat:((180*M_PI)/180)];
        halfTurn.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
        halfTurn.duration = 0.25;
        halfTurn.repeatCount = 1;
        [button.layer addAnimation:halfTurn forKey:@"180"];
        button.transform = CGAffineTransformMakeRotation( 0 );
        [rotatedCellIndexes removeObject:indexPath];
        [tableView deleteRowsAtIndexPaths:[self removeDetailDataAndCreateIndexPaths:[floorUpdates objectAtIndex:indexPath.row] origin:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    [tableView endUpdates];
    [CATransaction commit];
}

#pragma mark - Detail expansion

- (NSArray *)addDetailDataAndCreateIndexPaths:(FloorUpdate *)floorUpdate origin:(NSIndexPath *)origin {
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    NSUInteger offset = 1;
    for (Bill * bill in [floorUpdate bills]) {
        [array addObject:[NSIndexPath indexPathForRow:origin.row + offset inSection:origin.section]];
        [floorUpdates insertObject:bill atIndex:origin.row + offset];
        offset += 1;
    }
    for (Legislator * legislator in [floorUpdate legislators]) {
        [array addObject:[NSIndexPath indexPathForRow:origin.row + offset inSection:origin.section]];
        [floorUpdates insertObject:legislator atIndex:origin.row + offset];
        offset += 1;
    }
    return array;
}

- (NSArray *)removeDetailDataAndCreateIndexPaths:(FloorUpdate *)floorUpdate origin:(NSIndexPath *)origin {
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:5];
    NSUInteger offset = 1;
    for (Bill * bill in [floorUpdate bills]) {
        [array addObject:[NSIndexPath indexPathForRow:origin.row + offset inSection:origin.section]];
        [floorUpdates removeObject:bill];
        offset += 1;
    }
    for (Legislator * legislator in [floorUpdate legislators]) {
        [array addObject:[NSIndexPath indexPathForRow:origin.row + offset inSection:origin.section]];
        [floorUpdates removeObject:legislator];
        offset += 1;
    }
    return array;
}



@end
