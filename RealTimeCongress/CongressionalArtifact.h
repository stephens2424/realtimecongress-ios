//
//  CongressionalArtifact.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/9/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SunlightLabsRequest;
@class SunlightLabsConnection;

static NSString * ReceivedCongressionalInformationNotification = @"ReceivedCongressionalInformationNotification";

typedef enum {
    InformationAvailable,
    InformationUnobtained,
    InformationRequested,
    InformationNotApplicable,
    InformationUnavailable,
    InformationAvailabilityRequested
} InformationAvailability;

@interface CongressionalArtifact : NSObject {
    @protected
    SunlightLabsConnection * _connection;
    BOOL _abbreviated;
}

@property (readonly) BOOL abbreviated;

- (void)requestInformationWithRequest:(SunlightLabsRequest *)request;
- (void)receiveInformation:(NSNotification *)notification;
- (void)cancelRequest;

@end
