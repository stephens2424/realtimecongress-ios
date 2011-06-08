//
//  FloorUpdate.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FloorUpdate : NSObject {
@private
    NSString * _displayText;
    NSString * _displayTextWithDate;
    NSDate * _date;
    NSString * _displayDate;
    CGFloat _textHeight;
}

@property (readonly) NSString * displayText;
@property (readonly) NSDate * date;
@property (readonly) NSString * displayDate;
@property (readonly) NSString * displayTextWithDate;
@property (readonly) CGFloat textHeight;
@property (readonly) CGFloat textViewHeightRequired;

- (id)initWithDisplayText:(NSString *)text atDate:(NSDate *)date;

@end
