//
//  SunlightLabsRequest.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/3/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "SunlightLabsRequest.h"


@implementation SunlightLabsRequest

@synthesize requestType = _requestType;
@synthesize request = _request;

- (id)initWithParameterDictionary:(NSDictionary *)parameters requestType:(SunlightLabsRequestType)requestType {
    self = [super init];
    if (self) {
        _requestType = requestType;
        NSMutableString * requestURLString = [[NSMutableString alloc] initWithString:@"http://api.realtimecongress.org/api/v1/"];
        switch (_requestType) {
            case 1:
                [requestURLString appendString:@"bills"];
                break;
            case 2:
                [requestURLString appendString:@"votes"];
                break;
            case 3:
                [requestURLString appendString:@"amendments"];
                break;
            case 4:
                [requestURLString appendString:@"videos"];
                break;
            case 5:
                [requestURLString appendString:@"floor_updates"];
                break;
            case 6:
                [requestURLString appendString:@"committee_hearings"];
                break;
            case 7:
                [requestURLString appendString:@"documents"];
                break;
            default:
                break;
        }
        [requestURLString appendString:@".json?"];
        for (NSString * key in parameters) {
            [requestURLString appendFormat:@"%@=%@&",key,[parameters objectForKey:key]];
        }
        _request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestURLString]];
        [requestURLString release];
        [_request addValue:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"APIKeys" ofType:@"plist"]] objectForKey:@"SunlightLabsKey"] forHTTPHeaderField:@"X-APIKEY"];
    }
    return self;
}

- (void)dealloc
{
    [_request release];
    [super dealloc];
}

@end
