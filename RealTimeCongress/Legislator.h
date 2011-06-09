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
    NSString * _title;
    NSString * _firstname;
    NSString * _middlename;
    NSString * _lastname;
    NSString * _nameSuffix;
    NSString * _nickname;
    Gender _gender;
    PoliticalParty _party;
    NSString * _state;
    NSString * _district;
    BOOL _inOffice;
    NSString * _phoneNumber;
    NSString * _faxNumber;
    NSURL * _website;
    NSURL * _webContact;
    NSString * _email;
    NSString * _congressAddress;
    NSUInteger _bioguideId;
    NSUInteger _votesmartId;
    NSUInteger _fecId;
    NSUInteger _govTrackId;
    NSUInteger _crpId;
    NSURL * _congresspediaURL;
    NSString * _twitterId;
    NSURL * _youtubeURL;
    NSString * _facebookId;
    SenateClass _senateClass;
    NSDate * _birthdate;
    NSDictionary * _informationAvailibilityDictionary;
    SunlightLabsConnection * _connection;
}

@property (retain) NSString * title;
@property (retain) NSString * firstname;
@property (retain) NSString * middlename;
@property (retain) NSString * lastname;
@property (retain) NSString * nameSuffix;
@property (retain) NSString * nickname;
@property Gender gender;
@property PoliticalParty party;
@property (retain) NSString * state;
@property (retain) NSString * district;
@property BOOL inOffice;
@property (retain) NSString * phoneNumber;
@property (retain) NSString * faxNumber;
@property (retain) NSURL * website;
@property (retain) NSURL * webContact;
@property (retain) NSString * email;
@property (retain) NSString * congressAddress;
@property NSUInteger bioguideId;
@property NSUInteger votesmartId;
@property NSUInteger fecId;
@property NSUInteger govTrackId;
@property NSUInteger crpId;
@property (retain) NSURL * congresspediaURL;
@property (retain) NSString * twitterId;
@property (retain) NSURL * youtubeURL;
@property (retain) NSString * facebookId;
@property SenateClass senateClass;
@property (retain) NSDate * birthdate;

@end
