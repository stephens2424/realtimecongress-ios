//
//  Legislator.m
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/8/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import "Legislator.h"
#import "SunlightLabsRequest.h"
#import "SunlightLabsConnection.h"

@interface Legislator (Private)

- (void)receiveInformation:(NSNotification *)notification;

@end


@implementation Legislator

@synthesize title = _title;
@synthesize firstname = _firstname;
@synthesize middlename = _middlename;
@synthesize lastname = _lastname;
@synthesize nameSuffix = _nameSuffix;
@synthesize nickname = _nickname;
@synthesize gender = _gender;
@synthesize party = _party;
@synthesize state = _state;
@synthesize district = _district;
@synthesize inOffice = _inOffice;
@synthesize phoneNumber = _phoneNumber;
@synthesize faxNumber = _faxNumber;
@synthesize website = _website;
@synthesize webContact = _webContact;
@synthesize email = _email;
@synthesize congressAddress = _congressAddress;
@synthesize bioguideId = _bioguideId;
@synthesize votesmartId = _votesmartId;
@synthesize fecId = _fecId;
@synthesize govTrackId = _govTrackId;
@synthesize crpId = _crpId;
@synthesize congresspediaURL = _congresspediaURL;
@synthesize twitterId = _twitterId;
@synthesize youtubeURL = _youtubeURL;
@synthesize facebookId = _facebookId;
@synthesize senateClass = _senateClass;
@synthesize birthdate = _birthdate;

- (void)requestInformation {
    if (_connection) {
        [self receiveInformation:[NSNotification notificationWithName:nil object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSError errorWithDomain:@"CongressModel" code:1001 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Connection already in progress for this artifact of congress.",@"NSLocalizedDescriptionKey", nil]],@"error", nil]]];
        return;
    }
    SunlightLabsRequest * request;
    if ([_informationAvailibilityDictionary objectForKey:@"bioguideId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:[[NSNumber numberWithUnsignedInteger:_bioguideId] stringValue],@"bioguide_id", nil]];
    } else if ([_informationAvailibilityDictionary objectForKey:@"votesmartId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:[[NSNumber numberWithUnsignedInteger:_votesmartId] stringValue],@"votesmart_id", nil]];
    } else if ([_informationAvailibilityDictionary objectForKey:@"fecId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:[[NSNumber numberWithUnsignedInteger:_fecId] stringValue],@"fec_id", nil]];
    } else if ([_informationAvailibilityDictionary objectForKey:@"govTrackId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:[[NSNumber numberWithUnsignedInteger:_govTrackId] stringValue],@"govtrack_id", nil]];
    } else if ([_informationAvailibilityDictionary objectForKey:@"crpId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:[[NSNumber numberWithUnsignedInteger:_crpId] stringValue],@"crp_id", nil]];
    } else if ([_informationAvailibilityDictionary objectForKey:@"lastname"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:_lastname,@"lastname", nil]];
    } else {
        [self receiveInformation:[NSNotification notificationWithName:nil object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSError errorWithDomain:@"CongressModel" code:1000 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Not enough information to identify artifact of Congress",@"NSLocalizedDescriptionKey", nil]],@"error", nil]]];
        return;
    }
    _connection = [[SunlightLabsConnection alloc] initWithSunlightLabsRequest:request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveInformation:) name:SunglightLabsRequestFinishedNotification object:_connection];
    [_connection sendRequest];
}

- (void)receiveInformation:(NSNotification *)notification {
    if ([[notification userInfo] objectForKey:@"error"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ReceivedCongressionalInformationNotification object:self userInfo:[notification userInfo]];
    }
}

- (NSString *)title:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"title"] unsignedIntegerValue];
    return _title;
}

- (NSString *)firstname:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"firstname"] unsignedIntegerValue];
    return _firstname;
}

- (NSString *)middlename:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"middlename"] unsignedIntegerValue];
    return _middlename;
}

- (NSString *)lastname:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"lastname"] unsignedIntegerValue];
    return _lastname;
}

- (NSString *)nameSuffix:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"nameSuffix"] unsignedIntegerValue];
    return _nameSuffix;
}

- (NSString *)nickname:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"nickname"] unsignedIntegerValue];
    return _nickname;
}

- (Gender)gender:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"gender"] unsignedIntegerValue];
    return _gender;
}

- (PoliticalParty)party:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"party"] unsignedIntegerValue];
    return _party;
}

- (NSString *)state:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"state"] unsignedIntegerValue];
    return _state;
}

- (NSString *)district:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"district"] unsignedIntegerValue];
    return _district;
}

- (BOOL)inOffice:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"inOffice"] unsignedIntegerValue];
    return _inOffice;
}

- (NSString *)phoneNumber:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"phoneNumber"] unsignedIntegerValue];
    return _phoneNumber;
}

- (NSString *)faxNumber:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"faxNumber"] unsignedIntegerValue];
    return _faxNumber;
}

- (NSURL *)website:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"website"] unsignedIntegerValue];
    return _website;
}

- (NSURL *)webContact:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"webContact"] unsignedIntegerValue];
    return _webContact;
}

- (NSString *)email:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"email"] unsignedIntegerValue];
    return _congressAddress;
}

- (NSString *)congressAddress:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"congressAddress"] unsignedIntegerValue];
    return _congressAddress;
}

- (NSUInteger)bioguideId:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"bioguideId"] unsignedIntegerValue];
    return _bioguideId;
}

- (NSUInteger)votesmartId:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"votesmartId"] unsignedIntegerValue];
    return _votesmartId;
}

- (NSUInteger)fecId:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"fecId"] unsignedIntegerValue];
    return _fecId;
}

- (NSUInteger)govTrackId:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"govTrackId"] unsignedIntegerValue];
    return _govTrackId;
}

- (NSUInteger)crpId:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"crpId"] unsignedIntegerValue];
    return _crpId;
}

- (NSURL *)congresspediaURL:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"congresspediaURL"] unsignedIntegerValue];
    return _congresspediaURL;
}

- (NSString *)twitterId:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"twitterId"] unsignedIntegerValue];
    return _twitterId;
}

- (NSURL *)youtubeURL:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"youtubeURL"] unsignedIntegerValue];
    return _youtubeURL;
}

- (NSString *)facebookId:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"facebookId"] unsignedIntegerValue];
    return _facebookId;
}

- (SenateClass)senateClass:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"senateClass"] unsignedIntegerValue];
    return _senateClass;
}

- (NSDate *)birthdate:(InformationAvailability *)availability {
    * availability = [[_informationAvailibilityDictionary objectForKey:@"birthdate"] unsignedIntegerValue];
    return _birthdate;
}

@end
