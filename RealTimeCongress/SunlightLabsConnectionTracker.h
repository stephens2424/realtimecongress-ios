//
//  SunlightLabsConnectionTracker.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/13/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//


@interface SunlightLabsConnectionTracker : NSObject {
    SunlightLabsConnectionTracker * sharedInstance;
    NSUInteger openConnections;
}

+ (SunlightLabsConnectionTracker *)sharedInstance;
- (void)addConnection;
- (void)reduceConnection;

@end
