//
//  LegislatorProfileViewController.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/10/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Legislator;

@interface LegislatorProfileViewController : UITableViewController {
    @private
    Legislator * _legislator;
}

@property (nonatomic,retain) Legislator * legislator;

- (IBAction)websiteButtonAction:(id)sender;
- (IBAction)districtMapButtonAction:(id)sender; 

@end
