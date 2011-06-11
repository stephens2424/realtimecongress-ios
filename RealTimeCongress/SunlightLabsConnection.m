//
//  SunlightLabsConnection.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "SunlightLabsConnection.h"
#import "SunlightLabsRequest.h"
#import "JSONKit.h"

@implementation SunlightLabsConnection

- (id)initWithSunlightLabsRequest:(SunlightLabsRequest *)request {
    self = [super init];
    if (self) {
        _request = [request retain];
        _receivedData = [[NSMutableData alloc] initWithCapacity:10];
        _cancelled = NO;
    }
    return self;
}

- (void)sendRequest {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [NSURLConnection connectionWithRequest:[_request request] delegate:self];
}
- (void)cancel {
    _cancelled = YES;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (_cancelled) {
        [connection cancel];
    } else {
        [_receivedData appendData:data];
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Sunlight Labs Connection did fail with error:%@",error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary * decodedData;
    if (!_cancelled) {
        decodedData = [[[JSONDecoder decoder] objectWithData:_receivedData] retain];
    }
    if (!_cancelled) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SunglightLabsRequestFinishedNotification object:self userInfo:decodedData];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)dealloc
{
    [_receivedData release];
    [_request release];
    [super dealloc];
}

@end
