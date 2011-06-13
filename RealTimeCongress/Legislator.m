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
- (void)receivePhoto:(NSNotification *)notification;

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
@synthesize photo = _photo;

@synthesize fullName;
@synthesize parentheticalSeat;
@synthesize partyLetter;
@synthesize partyString;

- (id)initWithBioguideId:(NSString *)bioguideId {
    self = [super init];
    if (self) {
        _bioguideId = bioguideId;
    }
    return self;
}

- (void)requestInformation {
    _informationRequested = YES;
    if (_connection) {
        [self receiveInformation:[NSNotification notificationWithName:nil object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSError errorWithDomain:@"CongressModel" code:1001 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Connection already in progress for this artifact of congress.",@"NSLocalizedDescriptionKey", nil]],@"error", nil]]];
        return;
    }
    SunlightLabsRequest * request;
    if ([_informationAvailibilityDictionary objectForKey:@"bioguideId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:_bioguideId,@"bioguide_id", nil] multiple:NO];
    } else if ([_informationAvailibilityDictionary objectForKey:@"votesmartId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:_votesmartId,@"votesmart_id", nil] multiple:NO];
    } else if ([_informationAvailibilityDictionary objectForKey:@"fecId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:_fecId,@"fec_id", nil] multiple:NO];
    } else if ([_informationAvailibilityDictionary objectForKey:@"govTrackId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:_govTrackId,@"govtrack_id", nil] multiple:NO];
    } else if ([_informationAvailibilityDictionary objectForKey:@"crpId"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:_crpId,@"crp_id", nil] multiple:NO];
    } else if ([_informationAvailibilityDictionary objectForKey:@"lastname"] == InformationAvailable) {
        request = [[SunlightLabsRequest alloc] initLegislatorRequestWithParameters:[NSDictionary dictionaryWithObjectsAndKeys:_lastname,@"lastname", nil] multiple:NO];
    } else {
        [self receiveInformation:[NSNotification notificationWithName:nil object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSError errorWithDomain:@"CongressModel" code:1000 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Not enough information to identify artifact of Congress",@"NSLocalizedDescriptionKey", nil]],@"error", nil]]];
        return;
    }
    [super requestInformationWithRequest:request];
}

- (void)receiveInformation:(NSNotification *)notification {
    if ([[notification userInfo] objectForKey:@"error"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ReceivedCongressionalInformationNotification object:self userInfo:[notification userInfo]];
        _abbreviated = YES;
    } else {
        NSDictionary * data = [[[notification userInfo] objectForKey:@"response"] objectForKey:@"legislator"];
        _title = [[data objectForKey:@"title"] retain];
        _firstname = [[data objectForKey:@"firstname"] retain];
        _middlename = [[data objectForKey:@"middlename"] retain];
        _lastname = [[data objectForKey:@"lastname"] retain];
        _nameSuffix = [[data objectForKey:@"name_suffix"] retain];
        _nickname = [[data objectForKey:@"nickname"] retain];
        if ([[data objectForKey:@"gender"] isEqualToString:@"M"]) {
            _gender = [[NSNumber alloc] initWithInt:Male];
        } else if ([[data objectForKey:@"gender"] isEqualToString:@"F"]) {
            _gender = [[NSNumber alloc] initWithInt:Female];
        } else {
            _gender = nil;
        }
        if ([[data objectForKey:@"party"] isEqualToString:@"D"]) {
            _party = [[NSNumber alloc] initWithInt:Democrat];
        } else if ([[data objectForKey:@"party"] isEqualToString:@"R"]) {
            _party = [[NSNumber alloc] initWithInt:Republican];
        } else if ([[data objectForKey:@"party"] isEqualToString:@"I"]) {
            _party = [[NSNumber alloc] initWithInt:Independent];
        } else {
            _party = nil;
        }
        _state = [[data objectForKey:@"state"] retain];
        _district = [[data objectForKey:@"district"] retain];
        if ([data objectForKey:@"in_office"]) {
            _inOffice = [[NSNumber alloc] initWithBool:YES];
        } else {
            _inOffice = [[NSNumber alloc] initWithBool:NO];
        }
        _phoneNumber = [[data objectForKey:@"phone_number"] retain];
        _faxNumber = [[data objectForKey:@"fax_number"] retain];
        if ([data objectForKey:@"website"])
            _website = [[NSURL alloc] initWithString:[data objectForKey:@"website"]];
        if ([data objectForKey:@"web_contact"])
            _webContact = [[NSURL alloc] initWithString:[data objectForKey:@"web_contact"]];
        _email = [[data objectForKey:@"email"] retain];
        _congressAddress = [[data objectForKey:@"congress_address"] retain];
        _bioguideId = [[data objectForKey:@"bioguide_id"] retain];
        _votesmartId = [[data objectForKey:@"votesmart_id"] retain];
        _fecId = [[data objectForKey:@"fec_id"] retain];
        _govTrackId = [[data objectForKey:@"govtrack_id"] retain];
        _crpId = [[data objectForKey:@"crp_id"] retain];
        if ([data objectForKey:@"congresspedia_url"])
            _congresspediaURL = [[NSURL alloc] initWithString:[data objectForKey:@"congresspedia_url"]];
        _twitterId = [[data objectForKey:@"twitter_id"] retain];
        if ([data objectForKey:@"youtube_url"])
            _youtubeURL = [[NSURL alloc] initWithString:[data objectForKey:@"youtube_url"]];
        _facebookId = [[data objectForKey:@"facebook_id"] retain];
        if ([[data objectForKey:@"senateClass"] isEqualToString:@"I"])
            _senateClass = [[NSNumber alloc] initWithInt:ClassI];
        else if ([[data objectForKey:@"senateClass"] isEqualToString:@"II"])
            _senateClass = [[NSNumber alloc] initWithInt:ClassII];
        else if ([[data objectForKey:@"senateClass"] isEqualToString:@"III"])
            _senateClass = [[NSNumber alloc] initWithInt:ClassIII];
        else
            _senateClass = nil;
        if ([data objectForKey:@"birthdate"]) {
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            _birthdate = [[formatter dateFromString:[data objectForKey:@"birthdate"]] retain];
            [formatter release];
        }
        [super receiveInformation:notification];
        _abbreviated = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:ReceivedCongressionalInformationNotification object:self];
    }
}

- (void)requestPhoto {
    if (!_photoConnection && !_photo) {
        _photoRequested = YES;
        SunlightLabsRequest * photoRequest = [[SunlightLabsRequest alloc] initLegislatorPhotoRequest:_bioguideId withSize:MediumPhotoSize];
        _photoConnection = [[SunlightLabsConnection alloc] initWithSunlightLabsRequest:photoRequest];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePhoto:) name:SunglightLabsRequestFinishedNotification object:_photoConnection];
        [_photoConnection sendRequest];
        [photoRequest release];
    }
}
- (void)receivePhoto:(NSNotification *)notification {
    [_photoConnection release];
    _photoConnection = nil;
    _photo = [[[notification userInfo] objectForKey:@"photo"] retain];
    [[NSNotificationCenter defaultCenter] postNotificationName:ReceivedCongressionalInformationNotification object:self userInfo:[NSDictionary dictionaryWithObject:self forKey:@"legislator"]];
}

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@",_firstname,_lastname];
}

- (NSString *)parentheticalSeat {
    return [NSString stringWithFormat:@"(%@ - %@ %@)",[self partyLetter],[self state],[self district]];
}

- (NSString *)partyLetter {
    switch ([_party intValue]) {
        case Democrat :
            return @"D";
            break;
        case Republican :
            return @"R";
            break;
        case Independent :
            return @"I";
            break;
        default:
            return nil;
    }
}

- (NSString *)partyString {
    switch ([_party intValue]) {
        case Democrat :
            return @"Democrat";
            break;
        case Republican :
            return @"Republican";
            break;
        case Independent :
            return @"Independent";
            break;
        default:
            return nil;
    }
}

@end
