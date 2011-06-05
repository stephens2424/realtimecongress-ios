//
//  SunlightLabsConnection.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SunlightLabsRequest;

static NSString * SunglightLabsRequestFinishedNotification = @"SunglightLabsRequestFinishedNotification";

@interface SunlightLabsConnection : NSObject {
@private
    SunlightLabsRequest * _request;
    NSMutableData * _receivedData;
}
- (id)initWithSunlightLabsRequest:(SunlightLabsRequest *)request;
- (void)sendRequest;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
