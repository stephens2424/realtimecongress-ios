//
//  SunlightLabsConnection.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SunlightLabsRequest.h"

static NSString * SunglightLabsRequestFinishedNotification = @"SunglightLabsRequestFinishedNotification";

@interface SunlightLabsConnection : NSObject {
@private
    SunlightLabsRequest * _request;
    NSMutableData * _receivedData;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
