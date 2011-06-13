//
//  LegislatorViewController.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/10/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Legislator;
@class LegislatorProfileViewController;

@interface LegislatorViewController : UIViewController <UITabBarDelegate> {
    @private
    IBOutlet UITabBar * tabBar;
    IBOutlet UIView * tabView;
    Legislator * _legislator;
    LegislatorProfileViewController * profileViewController;
}

@property (nonatomic,retain) Legislator * legislator;

@end
