//
//  Bill.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Legislator;

typedef enum {
    Pass,
    Fail,
    None
} LegislativeResult;

@interface Bill : NSObject {
@private
    NSNumber * _billId;
    NSString * _billType;
    NSNumber * _billNumber;
    NSString * _billCode;
    NSNumber * _congressionalSession;
    NSString * _chamber;
    BOOL _abbreviated;
    
    NSString * _shortTitle;
    NSString * _officialTitle;
    NSString * _popularTitle;
    NSArray * _titles;
    
    NSString * _summary;
    NSNumber * _sponsorId;
    Legislator * _sponsor;
    
    NSArray * _cosponsors;
    NSArray * _committees;
    NSArray * _amendments;
    NSArray * _keywords;
    NSArray * _actions;
    
    NSArray * _passageVotes;
    NSArray * _relatedBills;
    NSDate * _introducedAt;
    
    LegislativeResult _senateResult;
    NSDate * _senateResultAt;
    LegislativeResult _houseResult;
    NSDate * _houseResultAt;
    
    BOOL _awaitingSignature;
    NSDate * _awaitingSignatureSince;
    BOOL _vetoed;
    NSDate * _vetoedAt;
    
    LegislativeResult _senateOverrideResult;
    NSDate * _senateOverrideResultAt;
    LegislativeResult _houseOverrideResult;
    NSDate * _houseOverrideResultAt;
    
    BOOL _enacted;
    NSDate * _enactedAt;
}

@property (readonly) NSNumber * billId;
@property (readonly) NSString * billType;
@property (readonly) NSNumber * billNumber;
@property (readonly) NSString * billCode;
@property (readonly) NSNumber * congressionalSession;
@property (readonly) NSString * chamber;
@property (readonly) BOOL abbreviated;

@property (readonly) NSString * shortTitle;
@property (readonly) NSString * officialTitle;
@property (readonly) NSString * popularTitle;
@property (readonly) NSArray * titles;

@property (readonly) NSString * summary;
@property (readonly) NSNumber * sponsorId;
@property (readonly) Legislator * sponsor;

@property (readonly) NSArray * cosponsors;
@property (readonly) NSArray * committees;
@property (readonly) NSArray * amendments;
@property (readonly) NSArray * keywords;
@property (readonly) NSArray * actions;

@property (readonly) NSArray * passageVotes;
@property (readonly) NSArray * relatedBills;
@property (readonly) NSDate * introducedAt;

@property (readonly) LegislativeResult senateResult;
@property (readonly) NSDate * senateResultAt;
@property (readonly) LegislativeResult houseResult;
@property (readonly) NSDate * houseResultAt;

@property (readonly) BOOL awaitingSignature;
@property (readonly) NSDate * awaitingSignatureSince;
@property (readonly) BOOL vetoed;
@property (readonly) NSDate * vetoedAt;

@property (readonly) LegislativeResult senateOverrideResult;
@property (readonly) NSDate * senateOverrideResultAt;
@property (readonly) LegislativeResult houseOverrideResult;
@property (readonly) NSDate * houseOverrideResultAt;

@property (readonly) BOOL enacted;
@property (readonly) NSDate * enactedAt;

@end
