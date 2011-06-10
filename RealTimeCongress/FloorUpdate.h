//
//  FloorUpdate.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Legislator.h"
#import "Bill.h"

@interface FloorUpdate : NSObject {
@private
    NSString * _displayText;
    NSString * _displayTextWithDate;
    NSDate * _date;
    NSString * _displayDate;
    CGFloat _textHeight;
    
    NSMutableSet * _legislators;
    NSMutableSet * _bills;
}

@property (readonly) NSString * displayText;
@property (readonly) NSDate * date;
@property (readonly) NSString * displayDate;
@property (readonly) NSString * displayTextWithDate;
@property (readonly) CGFloat textHeight;
@property (readonly) CGFloat textViewHeightRequired;
@property (readonly) NSSet * legislators;
@property (readonly) NSSet * bills;
@property (readonly) BOOL hasAbbreviations;

- (id)initWithDisplayText:(NSString *)text atDate:(NSDate *)date;
- (void)addLegislator:(Legislator *)legislator;
- (void)addBill:(Bill *)bill;

@end
