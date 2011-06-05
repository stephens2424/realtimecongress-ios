//
//  Bill.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/4/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "Bill.h"

@implementation Bill

@synthesize billId = _billId;
@synthesize billType = _billType;
@synthesize billNumber = _billNumber;
@synthesize billCode = _billCode;
@synthesize congressionalSession = _congressionalSession;
@synthesize chamber = _chamber;
@synthesize abbreviated = _abbreviated;
@synthesize shortTitle = _shortTitle;
@synthesize officialTitle = _officialTitle;
@synthesize popularTitle = _popularTitle;
@synthesize titles = _titles;
@synthesize summary = _summary;
@synthesize sponsorId = _sponsorId;
@synthesize sponsor = _sponsor;
@synthesize cosponsors = _cosponsors;
@synthesize committees = _committees;
@synthesize amendments = _amendments;
@synthesize keywords = _keywords;
@synthesize actions = _actions;
@synthesize passageVotes = _passageVotes;
@synthesize relatedBills = _relatedBills;
@synthesize introducedAt = _introducedAt;
@synthesize senateResult = _senateResult;
@synthesize senateResultAt = _senateResultAt;
@synthesize houseResult = _houseResult;
@synthesize houseResultAt = _houseResultAt;
@synthesize awaitingSignature = _awaitingSignature;
@synthesize awaitingSignatureSince = _awaitingSignatureSince;
@synthesize vetoed = _vetoed;
@synthesize vetoedAt = _vetoedAt;
@synthesize senateOverrideResult = _senateOverrideResult;
@synthesize senateOverrideResultAt = _senateOverrideResultAt;
@synthesize houseOverrideResult = _houseOverrideResult;
@synthesize houseOverrideResultAt = _houseOverrideResultAt;
@synthesize enacted = _enacted;
@synthesize enactedAt = _enactedAt;

- (id)initWithBillId:(NSNumber *)billId {
    self = [super init];
    if (self) {
        _billId = billId;
    }
    return self;
}

- (void)requestData {
    
}

- (void)dealloc {
    [_billId release];
    [_billType release];
    [_billNumber release];
    [_billCode release];
    [_congressionalSession release];
    [_chamber release];
    [_shortTitle release];
    [_officialTitle release];
    [_popularTitle release];
    [_titles release];
    [_summary release];
    [_sponsorId release];
    [_sponsor release];
    [_cosponsors release];
    [_committees release];
    [_amendments release];
    [_keywords release];
    [_actions release];
    [_passageVotes release];
    [_relatedBills release];
    [_introducedAt release];
    [_senateResultAt release];
    [_houseResultAt release];
    [_awaitingSignatureSince release];
    [_vetoedAt release];
    [_senateOverrideResultAt release];
    [_houseOverrideResultAt release];
    [_enactedAt release];
    [super dealloc];
}

@end
