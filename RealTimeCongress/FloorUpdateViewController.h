//
//  FloorUpdateViewController.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SunlightLabsConnection.h"

@interface FloorUpdateViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate> {
    @private
    SunlightLabsConnection * connection;
    NSMutableArray * floorUpdates;
}

@end
