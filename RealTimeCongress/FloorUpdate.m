//
//  FloorUpdate.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "FloorUpdate.h"


@implementation FloorUpdate

#define kTextViewFontSize        18.0

@synthesize displayText = _displayText;
@synthesize date = _date;
@synthesize displayDate = _displayDate;
@synthesize displayTextWithDate = _displayTextWithDate;
@synthesize textHeight = _textHeight;

- (id)initWithDisplayText:(NSString *)text atDate:(NSDate *)date {
    self = [super init];
    if (self) {
        _displayText = [text copy];
        _date = [date copy];
    }
    return self;
}

- (NSString *)displayTextWithDate {
    if (!_displayTextWithDate) {
        NSDateFormatter * dateFormatPrinter = [[NSDateFormatter alloc] init];
        [dateFormatPrinter setDateFormat:@"MMMM dd, yyyy HH:mm aa"];
        [dateFormatPrinter setTimeZone:[NSTimeZone systemTimeZone]];
        _displayTextWithDate = [[NSString alloc] initWithFormat:@"%@\n%@",[dateFormatPrinter stringFromDate:_date],_displayText];
    }
    return _displayTextWithDate;
}

- (NSString *)displayDate {
    if (!_displayDate) {
        NSDateFormatter * dateFormatPrinter = [[NSDateFormatter alloc] init];
        [dateFormatPrinter setDateFormat:@"MMMM dd, yyyy HH:mm aa"];
        [dateFormatPrinter setTimeZone:[NSTimeZone systemTimeZone]];
        _displayDate = [[NSString alloc] initWithFormat:@"%@",[dateFormatPrinter stringFromDate:_date]];
    }
    return _displayDate;
}

- (CGFloat)textHeight {
    return [_displayText sizeWithFont:[UIFont systemFontOfSize:kTextViewFontSize] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50.0, 10000.0) lineBreakMode:UILineBreakModeWordWrap].height;
}

- (void)dealloc
{
    [_displayTextWithDate release];
    [_displayText release];
    [_date release];
    [super dealloc];
}

@end
