//
//  CongressionalArtifact.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/9/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "CongressionalArtifact.h"
#import "SunlightLabsConnection.h"

@implementation CongressionalArtifact

@synthesize abbreviated;

- (void)requestInformationWithRequest:(SunlightLabsRequest *)request {
    _connection = [[SunlightLabsConnection alloc] initWithSunlightLabsRequest:request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveInformation:) name:SunglightLabsRequestFinishedNotification object:_connection];
    [_connection sendRequest];
}

- (void)receiveInformation:(NSNotification *)notification {
    [_connection release];
    _connection = nil;
}

- (void)cancelRequest {
    if (_connection) {
        [_connection cancel];
    }
}

- (void)dealloc {
    [_connection release];
    _connection = nil;
    [super dealloc];
}

@end
