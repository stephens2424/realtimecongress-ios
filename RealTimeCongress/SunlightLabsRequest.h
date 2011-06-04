//
//  SunlightLabsRequest.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/3/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Bills = 1,
    Votes = 2,
    Amendments = 3,
    Videos = 4,
    FloorUpdates = 5,
    CommitteeHearings = 6,
    Documents = 7
} SunlightLabsRequestType;

/**
 A request object to be used with SunlightLabsConnection.
 */
@interface SunlightLabsRequest : NSObject {
@private
    SunlightLabsRequestType _requestType;
    NSMutableURLRequest * _request;
}

@property (readonly) SunlightLabsRequestType requestType;
@property (readonly) NSURLRequest * request;

/**
 Initializes a SunlightLabsReqeust of the given type with the given parameters.
 @param parameters A dictionary containing the query parameters that will become part of the request URL.
 @param requestType The type of request.
 @return A SunglightLabsRequest object.
 */
- (id)initWithParameterDictionary:(NSDictionary *)parameters requestType:(SunlightLabsRequestType)requestType;

@end
