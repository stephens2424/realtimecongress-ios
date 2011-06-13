//
//  SunlightLabsConnectionTracker.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/13/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "SunlightLabsConnectionTracker.h"

static SunlightLabsConnectionTracker * sharedInstance = nil;

@implementation SunlightLabsConnectionTracker

- (id)init {
    self = [super init];
    if (self) {
        openConnections = 0;
    }
    return self;
}

- (void)addConnection {
    openConnections += 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)reduceConnection {
    openConnections -= 1;
    if (openConnections < 1) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

#pragma mark -
#pragma mark Singleton methods

+ (SunlightLabsConnectionTracker *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [[SunlightLabsConnectionTracker alloc] init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

@end
