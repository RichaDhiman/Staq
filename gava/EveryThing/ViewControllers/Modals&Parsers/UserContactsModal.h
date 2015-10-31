//
//  UserContactsModal.h
//  gava
//
//  Created by RICHA on 10/19/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserContactsModal : NSObject
@property(nonatomic,retain)NSString* contact_first_name;
@property(nonatomic,retain)NSString* contact_last_name;
@property(nonatomic,retain)NSString* contact_phone;
@property(nonatomic,retain)NSMutableArray* contact_emails;
@property(nonatomic,retain)NSString* contact_image;
@end
