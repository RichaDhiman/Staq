//
//  CardDetails.m
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.


#import "CardDetails.h"
#import "UserProfile.h"
@implementation CardDetails
@synthesize card_brand_id,card_id,card_number,card_pin,card_price,card_user_id,card_affiliate_link,card_link_title,card_brand_type,card_is_valid_id,card_event_number,card_is_custom,card_brand_name;

+(NSArray*)parserDicttoModalCardArr:(NSArray*)arr
{
    NSMutableArray *temparr=[[NSMutableArray alloc]init];
    for(NSDictionary *dict in arr)
    {
        
        CardDetails * cd=[[CardDetails alloc]init];
        cd=[CardDetails parserDicttoModalCarddict:dict];
        [temparr addObject:cd];
    }
    return temparr;
}



+(CardDetails*)parserDicttoModalCarddict:(NSDictionary*)dict
{
    CardDetails*cd=[[CardDetails alloc]init];
    
    cd.card_brand_id=[dict valueForKey:@"brand_id"];
    cd.card_id=[dict valueForKey:@"id"];
    cd.card_number=[dict valueForKey:@"card_number"];
    cd.card_pin=[dict valueForKey:@"pin"];
    cd.card_price=[dict valueForKey:@"price"];
    cd.card_user_id=[dict valueForKey:@"user_id"];
    cd.card_affiliate_link=[dict valueForKey:@"affiliate_link"];
    cd.card_link_title=[dict valueForKey:@"link_title"];
    cd.card_brand_type=[dict valueForKey:@"brand_type"];
    cd.card_is_valid_id=[dict valueForKey:@"is_valid_id"];
    cd.card_event_number=[dict valueForKey:@"event_number"];
    cd.card_is_custom=[dict valueForKey:@"is_custom"];
    cd.card_brand_name=[dict valueForKey:@"brand_name"];
    
    cd.brandDet=[UserProfile parserDicttoModalBranddict:[dict valueForKey:@"brand"] ];
 
       
    return cd;
    
}


+(void)saveCardsInfo:(NSArray*)arr
{
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"cards"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSArray*)getCardsInfo
{
    return [CardDetails parserDicttoModalCardArr:[[NSUserDefaults standardUserDefaults] valueForKey:@"cards"]];

}



@end
