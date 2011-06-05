//
//  SunlightLabsRequest.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/3/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "SunlightLabsRequest.h"

static NSString * RealTimeCongressBasePath = @"http://api.realtimecongress.org/api/v1/";
static NSString * SunlightCongressBasePath = @"http://services.sunlightlabs.com/api/";

@implementation SunlightLabsRequest

@synthesize requestType = _requestType;
@synthesize api = _api;
@synthesize request = _request;

+ (NSMutableString *)basePathFromRequestType:(APICollection)requestType {
    switch (requestType) {
        case Bills:
            return [NSMutableString stringWithFormat:@"%@%@",RealTimeCongressBasePath,@"bills"];
            break;
        case Votes:
            return [NSMutableString stringWithFormat:@"%@%@",RealTimeCongressBasePath,@"votes"];
            break;
        case Amendments:
            return [NSMutableString stringWithFormat:@"%@%@",RealTimeCongressBasePath,@"amendments"];
            break;
        case Videos:
            return [NSMutableString stringWithFormat:@"%@%@",RealTimeCongressBasePath,@"videos"];
            break;
        case FloorUpdates:
            return [NSMutableString stringWithFormat:@"%@%@",RealTimeCongressBasePath,@"floor_updates"];
            break;
        case CommitteeHearings:
            return [NSMutableString stringWithFormat:@"%@%@",RealTimeCongressBasePath,@"committee_hearings"];
            break;
        case Documents:
            return [NSMutableString stringWithFormat:@"%@%@",RealTimeCongressBasePath,@"documents"];
            break;
        case Legislators:
            return [NSMutableString stringWithFormat:@"%@%@",SunlightCongressBasePath,@"legislators"];
        default:
            return nil;
            break;
    }
}

+ (API)APIFromRequestType:(APICollection)requestType {
    switch (requestType) {
        case Bills:
            return RealTimeCongressAPI;
            break;
        case Votes:
            return RealTimeCongressAPI;
            break;
        case Amendments:
            return RealTimeCongressAPI;
            break;
        case Videos:
            return RealTimeCongressAPI;
            break;
        case FloorUpdates:
            return RealTimeCongressAPI;
            break;
        case CommitteeHearings:
            return RealTimeCongressAPI;
            break;
        case Documents:
            return RealTimeCongressAPI;
            break;
        case Legislators:
            return SunlightCongressAPI;
            break;
        default:
            return nil;
            break;
    }
}

- (id)initRequestWithParameterDictionary:(NSDictionary *)parameters APICollection:(APICollection)apiCollection APIMethod:(NSString *)apiMethod {
    self = [super init];
    if (self) {
        _requestCollection = apiCollection;
        _api = [SunlightLabsRequest APIFromRequestType:apiCollection];
        NSMutableString * requestURLString = [SunlightLabsRequest basePathFromRequestType:apiCollection];
        if (apiMethod) [requestURLString appendFormat:@".%@",apiMethod];
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
- (id)initLegislatorRequestWithParameters:(NSDictionary *)parameters {
    return [self initLegislatorRequestWithParameters:parameters multiple:YES];
}
- (id)initLegislatorRequestWithParameters:(NSDictionary *)parameters multiple:(BOOL)multiple {
    if (multiple) return [self initRequestWithParameterDictionary:parameters APICollection:Legislators APIMethod:@"getList"];
    else return [self initRequestWithParameterDictionary:parameters APICollection:Legislators APIMethod:@"get"];
}
- (id)initFloorUpdateRequestWithParameters:(NSDictionary *)parameters {
    return [self initRequestWithParameterDictionary:parameters APICollection:FloorUpdates APIMethod:nil];
}
- (void)dealloc
{
    [_request release];
    [super dealloc];
}

@end
