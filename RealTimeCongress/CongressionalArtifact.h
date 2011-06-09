//
//  CongressionalArtifact.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/9/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

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
    
}

@end
