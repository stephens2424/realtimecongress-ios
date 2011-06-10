//
//  Legislator.h
//  RealTimeCongress
//
//  Created by Stephen Searles on 6/8/11.
//  Copyright 2011 Sunlight Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CongressionalArtifact.h"
@class SunlightLabsConnection;

typedef enum {
    Democrat,
    Republican,
    Independent,
    PartyNotAvailable
} PoliticalParty;

typedef enum {
    Male,
    Female,
    Other,
    GenderNotAvailable
} Gender;

typedef enum {
    ClassI,
    ClassII,
    ClassIII,
    SenateClassNotAvailable
} SenateClass;

@interface Legislator : CongressionalArtifact {
    @private
    NSString * _title;
    NSString * _firstname;
    NSString * _middlename;
    NSString * _lastname;
    NSString * _nameSuffix;
    NSString * _nickname;
    NSNumber * _gender;
    NSNumber * _party;
    NSString * _state;
    NSString * _district;
    NSNumber * _inOffice;
    NSString * _phoneNumber;
    NSString * _faxNumber;
    NSURL * _website;
    NSURL * _webContact;
    NSString * _email;
    NSString * _congressAddress;
    NSString * _bioguideId;
    NSString * _votesmartId;
    NSString * _fecId;
    NSString * _govTrackId;
    NSString * _crpId;
    NSURL * _congresspediaURL;
    NSString * _twitterId;
    NSURL * _youtubeURL;
    NSString * _facebookId;
    NSNumber * _senateClass;
    NSDate * _birthdate;
    NSMutableDictionary * _informationAvailibilityDictionary;
    
    BOOL _informationRequested;
}

@property (readonly) NSString * title;
@property (readonly) NSString * firstname;
@property (readonly) NSString * middlename;
@property (readonly) NSString * lastname;
@property (readonly) NSString * nameSuffix;
@property (readonly) NSString * nickname;
@property (readonly) NSNumber * gender;
@property (readonly) NSNumber * party;
@property (readonly) NSString * state;
@property (readonly) NSString * district;
@property (readonly) NSNumber * inOffice;
@property (readonly) NSString * phoneNumber;
@property (readonly) NSString * faxNumber;
@property (readonly) NSURL * website;
@property (readonly) NSURL * webContact;
@property (readonly) NSString * email;
@property (readonly) NSString * congressAddress;
@property (readonly) NSString * bioguideId;
@property (readonly) NSString * votesmartId;
@property (readonly) NSString * fecId;
@property (readonly) NSString * govTrackId;
@property (readonly) NSString * crpId;
@property (readonly) NSURL * congresspediaURL;
@property (readonly) NSString * twitterId;
@property (readonly) NSURL * youtubeURL;
@property (readonly) NSString * facebookId;
@property (readonly) NSNumber * senateClass;
@property (readonly) NSDate * birthdate;

- (void)requestInformation;

@end
