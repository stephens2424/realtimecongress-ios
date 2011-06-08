//
//  CommitteeHearingsCell.m
//  RealTimeCongress
//
//  Created by Tom Tsai on 6/1/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "CommitteeHearingsCell.h"


@implementation CommitteeHearingsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCommitteeName:(NSString *) _committeeName {
    committeeName.text = _committeeName;
}

- (void)setTimeAndPlace:(NSString *) _timeAndPlace {
    timeAndPlace.text = _timeAndPlace;
}

- (void)setDescription:(NSString *) _description {
    description.text = _description;
}

- (void)dealloc
{
    [super dealloc];
}

@end
