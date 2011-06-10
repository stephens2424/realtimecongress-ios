//
//  FloorUpdate.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "FloorUpdate.h"


@implementation FloorUpdate

#define kTextViewFontSize        17.0 //This matches the height of the font in the UITextView in the nib (FloorUpdateTableViewCell.xib)

@synthesize displayText = _displayText;
@synthesize date = _date;
@synthesize displayDate = _displayDate;
@synthesize displayTextWithDate = _displayTextWithDate;
@synthesize textHeight = _textHeight;
@synthesize textViewHeightRequired;
@synthesize legislators = _legislators;
@synthesize bills = _bills;

- (id)initWithDisplayText:(NSString *)text atDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _displayText = [text copy];
        _date = [date copy];
        _textHeight = -1;
        _legislators = [[NSMutableSet alloc] initWithCapacity:5];
        _bills = [[NSMutableSet alloc] initWithCapacity:5];
    }
    return self;
}

- (NSString *)displayTextWithDate {
    if (!_displayTextWithDate) {
        NSDateFormatter * dateFormatPrinter = [[NSDateFormatter alloc] init];
        [dateFormatPrinter setDateFormat:@"MMMM dd, yyyy hh:mm aa"];
        [dateFormatPrinter setTimeZone:[NSTimeZone systemTimeZone]];
        _displayTextWithDate = [[NSString alloc] initWithFormat:@"%@\n%@",[dateFormatPrinter stringFromDate:_date],_displayText];
    }
    return _displayTextWithDate;
}

- (NSString *)displayDate {
    if (!_displayDate) {
        NSDateFormatter * dateFormatPrinter = [[NSDateFormatter alloc] init];
        [dateFormatPrinter setDateFormat:@"MMMM dd, yyyy hh:mm aa"];
        [dateFormatPrinter setTimeZone:[NSTimeZone systemTimeZone]];
        _displayDate = [[NSString alloc] initWithFormat:@"%@",[dateFormatPrinter stringFromDate:_date]];
    }
    return _displayDate;
}

- (CGFloat)textHeight {
    if (_textHeight == -1) {
        _textHeight = [_displayText sizeWithFont:[UIFont systemFontOfSize:kTextViewFontSize] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50.0, 10000.0) lineBreakMode:UILineBreakModeWordWrap].height;
    }
    return _textHeight;
}

- (CGFloat)textViewHeightRequired {
    return [self textHeight] + 15;
}

- (void)addLegislator:(Legislator *)legislator {
    [_legislators addObject:legislator];
}

- (void)addBill:(Bill *)bill {
    [_legislators addObject:bill];
}

- (void)dealloc
{
    [_displayTextWithDate release];
    [_displayText release];
    [_date release];
    [_legislators release];
    [_bills release];
    [super dealloc];
}

@end
