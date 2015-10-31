//
//  CardDetails.h
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"

@interface CardDetails : NSObject
@property(nonatomic,retain)NSString* card_id;
@property(nonatomic,retain)NSString* card_user_id;
@property(nonatomic,retain)NSString* card_brand_id;
@property(nonatomic,retain)NSString* card_number;
@property(nonatomic,retain)NSString* card_pin;
@property(nonatomic,retain)NSString* card_price;
@property(nonatomic,retain)UserProfile *brandDet;
@property(nonatomic,retain)NSString* card_affiliate_link;
@property(nonatomic,retain)NSString* card_link_title;
@property(nonatomic,retain)NSString* card_brand_type;
@property(nonatomic,retain)NSString* card_is_valid_id;
@property(nonatomic,retain)NSString* card_event_number;
@property(nonatomic,retain)NSString* card_is_custom;
@property(nonatomic,retain)NSString* card_brand_name;

@property(nonatomic,retain)NSString *Total;



+(NSArray*)parserDicttoModalCardArr:(NSArray*)arr;
+(CardDetails*)parserDicttoModalCarddict:(NSDictionary*)dict;

//+(void)saveCardsDet:(NSDictionary*)dict;
//+(CardDetails*)getCardsDet;

+(void)saveCardsInfo:(NSArray*)arr;
+(NSArray*)getCardsInfo;


@end
