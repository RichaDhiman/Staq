//
//  UserProfile.h
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "IOSRequest.h"
#import <SCLAlertView.h>
#import "Constants.h"

@interface UserProfile : NSObject
@property(nonatomic,retain)NSString* user_id;
@property(nonatomic,retain)NSString* user_first_name;
@property(nonatomic,retain)NSString* user_last_name;
@property(nonatomic,retain)NSString* user_access_token;
@property(nonatomic,retain)NSString* user_email;
@property(nonatomic,retain)NSString* user_facebook_id;
@property(nonatomic,retain)NSString* user_code;





//////brand details
@property(nonatomic,retain)NSString* bDet_id;
@property(nonatomic,retain)NSString* bDet_brand_id;
@property(nonatomic,retain)NSString* bDet_name;
@property(nonatomic,retain)NSString* bDet_logo;
@property(nonatomic,retain)NSString* bDet_minlogo;
@property(nonatomic,retain)NSString* bDet_brand_type;
@property(nonatomic,retain)NSString* bDet_brand_is_valid_id;
@property(nonatomic,retain)NSString* bDet_brand_event_number;


//  profile Info
+(UserProfile*)parserDicttoModalUserdict:(NSDictionary*)dict;

//family Share friends
+(NSArray*)parserDicttoModalUsersArr:(NSArray*)arr;
+(void)saveSyncFrndsInfo:(NSArray*)arr;
+(NSArray*)getSyncFrndsInfo;


+(void)saveProfile:(NSDictionary*)dict;
+(UserProfile*)getProfile;


//////branddetails
+(NSArray*)parserDicttoModalBrandsArr:(NSArray*)arr;
+(UserProfile*)parserDicttoModalBranddict:(NSDictionary*)dict;


+(void)saveBrandsInfo:(NSArray*)arr;
+(NSArray*)getBrandsInfo;

//+(void)apiViewCards:(NSString *)accessToken success: (void (^) (NSArray *response))success failure: (void (^) (NSString *error))failure;

@end
