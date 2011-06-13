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
static NSString * LegislatorPhotoBasePath = @"http://assets.sunlightfoundation.com/moc/";

@interface SunlightLabsRequest (Hidden)

+ (NSString *)photoSizeString:(PhotoSize)size;

@end

@implementation SunlightLabsRequest (Hidden)

+ (NSString *)photoSizeString:(PhotoSize)size {
    switch (size) {
        case SmallPhotoSize :
            return @"40x50";
            break;
        case MediumPhotoSize :
            return @"100x125";
            break;
        case LargePhotoSize :
            return @"200x250";
            break;
        default:
            return @"100x125";
    }
}

@end

@implementation SunlightLabsRequest

@synthesize requestType = _requestType;
@synthesize api = _api;
@synthesize request = _urlRequest;

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
            break;
        case LegislatorPhoto:
            return [NSMutableString stringWithFormat:@"%@",LegislatorPhotoBasePath];
            break;
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
            return InvalidAPI;
            break;
    }
}
- (id)initRequestWithURLString:(NSString *)requestString {
    self = [super init];
    if (self) {
        _urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]];
        //[_urlRequest addValue:[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"APIKeys" ofType:@"plist"]] objectForKey:@"SunlightLabsKey"] forHTTPHeaderField:@"X-APIKEY"];
    }
    return self;
}
- (id)initRequestWithParameterDictionary:(NSDictionary *)parameters APICollection:(APICollection)apiCollection APIMethod:(NSString *)apiMethod {
    _requestCollection = apiCollection;
    _api = [SunlightLabsRequest APIFromRequestType:apiCollection];
    NSMutableString * requestURLString = [SunlightLabsRequest basePathFromRequestType:apiCollection];
    if (apiMethod) [requestURLString appendFormat:@".%@",apiMethod];
    [requestURLString appendString:@".json?"];
    //the following line appends the apikey to the url. here for debugging purposes. the line to add the apikey to the header is commented out below
    [requestURLString appendFormat:@"apikey=%@&",[[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"APIKeys" ofType:@"plist"]] objectForKey:@"SunlightLabsKey"]];
    if (parameters) {
        for (NSString * key in parameters) {
            [requestURLString appendFormat:@"%@=%@&",key,[parameters objectForKey:key]];
        }
    }
    return [self initRequestWithURLString:requestURLString];
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
- (id)initLegislatorPhotoRequest:(NSString *)bioguideId withSize:(PhotoSize)size {
    _api = Photo;
    _requestCollection = LegislatorPhoto;
    return [self initRequestWithURLString:[NSString stringWithFormat:@"%@%@/%@.jpg",LegislatorPhotoBasePath,[SunlightLabsRequest photoSizeString:size],bioguideId]];
}
- (void)dealloc
{
    [_urlRequest release];
    [super dealloc];
}

@end
