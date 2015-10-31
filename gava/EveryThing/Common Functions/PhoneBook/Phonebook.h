//
//  Phonebook.h
//  Skoop
//
//  Created by Pargat  Dhillon on 31/07/15.
//  Copyright (c) 2015 Pargat Dhillon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface Phonebook : NSObject

+(void)getContactsFronPhonebook: (void (^) (NSArray *response))success failure: (void (^) (NSUInteger error))failure;

+(NSString*)trimStr:(NSString*)str;
@end
