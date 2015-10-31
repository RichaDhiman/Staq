//
//  UserProfile.m
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile
@synthesize user_access_token,user_email,user_facebook_id,user_first_name,user_id,user_last_name,bDet_brand_id,bDet_id,bDet_logo,bDet_minlogo,bDet_name,bDet_brand_type,user_code,bDet_brand_is_valid_id,bDet_brand_event_number;

/////NSUserdefaults ProfileInfo

+(void)saveProfile:(NSDictionary*)dict
{
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(UserProfile*)getProfile
{
    return [UserProfile parserDicttoModalUserdict:[[NSUserDefaults standardUserDefaults] valueForKey:@"user"]];
}

+(UserProfile*)parserDicttoModalUserdict:(NSDictionary*)dict
{
    UserProfile *pd=[[UserProfile alloc]init];
    
    pd.user_first_name=[dict valueForKey:@"first_name"];
    pd.user_id= [dict valueForKey:@"id"];
    pd.user_last_name=[dict valueForKey:@"last_name"];
    pd.user_facebook_id=[dict valueForKey:@"facebook_id"];
    pd.user_email=[dict valueForKey:@"email"];
    pd.user_access_token=[dict valueForKey:@"access_token"];
    pd.user_code=[dict valueForKey:@"code"];
    return pd;
}


+(NSArray*)parserDicttoModalUsersArr:(NSArray*)arr
{
    NSMutableArray *temparr=[[NSMutableArray alloc]init];
    for(NSDictionary *dict in arr)
    {
        
        UserProfile * cd=[[UserProfile alloc]init];
        cd=[UserProfile parserDicttoModalUserdict:dict];
        [temparr addObject:cd];
    }
    return temparr;
}



+(UserProfile*)parserDicttoModalBranddict:(NSDictionary*)dict
{
    UserProfile *bd=[[UserProfile alloc]init];
    
    bd.bDet_brand_id=[dict valueForKey:@"brand_id"];
    bd.bDet_id= [dict valueForKey:@"id"];
    bd.bDet_logo=[dict valueForKey:@"logo"];
    bd.bDet_minlogo=[dict valueForKey:@"minlogo"];
    bd.bDet_name=[dict valueForKey:@"name"];
    bd.bDet_brand_type=[dict valueForKey:@"brand_type"];
    bd.bDet_brand_is_valid_id=[dict valueForKey:@"is_valid_id"];
    bd.bDet_brand_event_number=[dict valueForKey:@"event_number"];
    
    return bd;
}


+(NSArray*)parserDicttoModalBrandsArr:(NSArray*)arr
{
    NSMutableArray *temparr=[[NSMutableArray alloc]init];
    for(NSDictionary *dict in arr)
    {
        
        UserProfile * cd=[[UserProfile alloc]init];
        cd=[UserProfile parserDicttoModalBranddict:dict];
        [temparr addObject:cd];
    }
    return temparr;
}


+(void)saveBrandsInfo:(NSArray*)arr
{
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"brand"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(NSArray*)getBrandsInfo
{
 return [UserProfile parserDicttoModalBrandsArr:[[NSUserDefaults standardUserDefaults] valueForKey:@"brand"]];
    
}


+(void)saveSyncFrndsInfo:(NSArray*)arr
{
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"users"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(NSArray*)getSyncFrndsInfo
{
    return [UserProfile parserDicttoModalUsersArr:[[NSUserDefaults standardUserDefaults] valueForKey:@"users"]];
    
}


@end
