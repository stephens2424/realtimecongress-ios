#import "RootViewController.h"
#import "AboutViewController.h"
#import "FloorUpdateViewController.h"
#import "CommitteeHearingsViewController.h"

@implementation RootViewController
@synthesize sectionNames;
@synthesize sectionIcons;

-(NSArray *)sectionNames {
    if (!sectionNames) {
        self.sectionNames = [NSArray arrayWithObjects:
                                @"Floor Updates",
                                @"Whip Notices", 
                                @"Hearings",
                                @"Documents",
                                @"About", nil];
    }
    return sectionNames;
}

-(NSArray *)sectionIcons {
    if (!sectionIcons) {
        self.sectionIcons = [NSArray arrayWithObjects:
                                [UIImage imageNamed:@"56-feed.png"],
                                [UIImage imageNamed:@"166-newspaper.png"],
                                [UIImage imageNamed:@"146-gavel.png"],
                                [UIImage imageNamed:@"179-notepad.png"],
                                [UIImage imageNamed:@"59-info.png"], nil];
    }
    return sectionIcons;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Main Menu";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
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

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sectionNames count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [self.sectionIcons objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.sectionNames objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // ...
    // Pass the selected object to the new view controller.
    
    if (indexPath.row == 1) {
        UITableViewController *whipController = [[UITableViewController alloc] initWithNibName:@"WhipNoticeViewController" bundle:nil];
        [self.navigationController pushViewController:whipController animated:YES];
        [whipController release];
    }
    
    if (indexPath.row == 2) {
        // Pushes the Committee Hearings view controller
        CommitteeHearingsViewController *hearingsController = [[CommitteeHearingsViewController alloc] initWithNibName:@"CommitteeHearingsViewController" bundle:nil];
        [self.navigationController pushViewController:hearingsController animated:YES];
        [hearingsController release];
    }
    
    if (indexPath.row == 4) {
        // Pushes the About Screen view controller
        AboutViewController *aboutController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil]; 
        [self.navigationController pushViewController:aboutController animated:YES];
        [aboutController release];
    } else if (indexPath.row == 0) {
        FloorUpdateViewController *floorUpdateController = [[FloorUpdateViewController alloc] initWithNibName:@"FloorUpdateViewController" bundle:nil];
        [self.navigationController pushViewController:floorUpdateController animated:YES];
        [floorUpdateController release];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
