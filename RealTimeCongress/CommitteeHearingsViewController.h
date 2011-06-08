//
//  CommitteeHearingsViewController.h
//  RealTimeCongress
//
//  Created by Tom Tsai on 5/25/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"

#define HOUSE_URL @"http://api.realtimecongress.org/api/v1/committee_hearings.json?apikey=dc060e7c2e154278a4167b2c4c571695&chamber=house"
#define SENATE_URL @"http://api.realtimecongress.org/api/v1/committee_hearings.json?apikey=dc060e7c2e154278a4167b2c4c571695&chamber=senate"

@interface CommitteeHearingsViewController : UITableViewController {
    NSArray *parsedHearingData;
    NSData *jsonData;
    NSDictionary *items;
    JSONDecoder *jsonKitDecoder;
    IBOutlet UISegmentedControl *chamberControl;
    NSEnumerator *hearingEnumerator;
    NSMutableArray *allHearings;
}

@property(nonatomic,retain) NSArray *parsedHearingData;
@property(nonatomic,retain) NSDictionary *items;
@property(nonatomic,retain) NSData *jsonData;
@property(nonatomic,retain) JSONDecoder *jsonKitDecoder;
@property(nonatomic,retain) IBOutlet UISegmentedControl *chamberControl;
@property(nonatomic,retain) NSEnumerator *hearingEnumerator;
@property(nonatomic,retain) NSMutableArray *allHearings;

- (void) refresh;
- (void) parseData;

@end
