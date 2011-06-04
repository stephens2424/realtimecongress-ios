//
//  SunlightLabsConnection.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "SunlightLabsConnection.h"


@implementation SunlightLabsConnection

- (id)initWithSunlightLabsRequest:(SunlightLabsRequest *)request {
    self = [super init];
    if (self) {
        _request = [request retain];
        _receivedData = [[NSMutableData alloc] initWithCapacity:10];
        [NSURLConnection connectionWithRequest:[request request] delegate:self];
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receivedData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Sunlight Labs Connection did fail with error:%@",error);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];
#warning incomplete method. handle interpreting received data
}

- (void)dealloc
{
    [_receivedData release];
    [_request release];
    [super dealloc];
}

@end