//
//  SunlightLabsRequest.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/3/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Bills,
    Votes,
    Amendments,
    Videos,
    FloorUpdates,
    CommitteeHearings,
    Documents,
    Legislators,
    LegislatorPhoto
} APICollection;

typedef enum {
    RealTimeCongressAPI,
    SunlightCongressAPI,
    Photo,
    InvalidAPI
} API;

typedef enum {
    SmallPhotoSize,
    MediumPhotoSize,
    LargePhotoSize
} PhotoSize;

/**
 A request object to be used with SunlightLabsConnection.
 */
@interface SunlightLabsRequest : NSObject {
@private
    APICollection _requestCollection;
    API _api;
    NSMutableURLRequest * _urlRequest;
}

/**
 The type of request to be sent.
 */
@property (readonly) APICollection requestType;
/**
 The API to which the request will be sent.
 */
@property (readonly) API api;
@property (readonly) NSURLRequest * request;

- (id)initRequestWithURLString:(NSString *)requestString;
/**
 Initializes a SunlightLabsReqeust of the given type with the given parameters.
 @param parameters A dictionary containing the query parameters that will become part of the request URL.
 @param apiCollection The API Collection the request will call (e.g. Bills, Legislators).
 @param apiMethod The API method the request will call (e.g. getList). If using an API without method calls, like RealTimeCongress, use nil.
 @return A SunglightLabsRequest object.
 */
- (id)initRequestWithParameterDictionary:(NSDictionary *)parameters APICollection:(APICollection)apiCollection APIMethod:(NSString *)apiMethod;
- (id)initLegislatorRequestWithParameters:(NSDictionary *)parameters;
- (id)initLegislatorRequestWithParameters:(NSDictionary *)parameters multiple:(BOOL)multiple;
- (id)initFloorUpdateRequestWithParameters:(NSDictionary *)parameters;
- (id)initLegislatorPhotoRequest:(NSString *)bioguideId withSize:(PhotoSize)size;

@end
