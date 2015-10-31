//
//  Phonebook.m
//  Skoop
//
//  Created by Pargat  Dhillon on 31/07/15.
//  Copyright (c) 2015 Pargat Dhillon. All rights reserved.
//

#import "Phonebook.h"
//#import "NSString+Functions.h"

@implementation Phonebook

+(void)getContactsFronPhonebook: (void (^) (NSArray *response))success failure: (void (^) (NSUInteger error))failure{
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"Denied");
        failure(ABAddressBookGetAuthorizationStatus());
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
        [Phonebook getContactList:^(NSArray *response) {
            success(response);
        }];
    } else{
        //3
        NSLog(@"Not determined");
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted){
                    //4
                    failure(ABAddressBookGetAuthorizationStatus());
                }
                //5
                [Phonebook getContactList:^(NSArray *response) {
                    success(response);
                }];
            });
        });
    }

}

+(void)getContactList: (void (^) (NSArray *response))success{
    
    //1
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (addressBook != nil) {
        
        CFArrayRef allSources = ABAddressBookCopyArrayOfAllSources(addressBook);
        NSMutableArray *contactsArray = [[NSMutableArray alloc] init];
        
        for (CFIndex i = 0; i < CFArrayGetCount(allSources); i++)
        {
            //2
            ABRecordRef source = (ABRecordRef)CFArrayGetValueAtIndex(allSources, i);
            ABPersonSortOrdering sortOrdering = ABPersonGetSortOrdering();
            CFArrayRef allPeopleInSource = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, sortOrdering );
            NSLog(@"Count allPeopleInSource: %li", CFArrayGetCount(allPeopleInSource));
            
            //3
            NSUInteger i = 0; for (i = 0; i < CFArrayGetCount(allPeopleInSource); i++)
            {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                
                ABRecordRef contactPerson = CFArrayGetValueAtIndex(allPeopleInSource, i);
                
                NSString *firstName = (__bridge  NSString *)ABRecordCopyValue(contactPerson,
                                                                              kABPersonFirstNameProperty);
                NSString *lastName = (__bridge  NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
                NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName?firstName:@"", lastName?lastName:@""];
                
                [dict setValue:[self trimStr:fullName] forKey:@"name"];
                
                
                ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(contactPerson, kABPersonPhoneProperty));
                
                NSMutableArray *phoneNos = [[NSMutableArray alloc] init];
                
                for(CFIndex j = 0; j< ABMultiValueGetCount(phones); j++)
                {
                    if ([(NSString *)(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j) length] == 0) {
                        continue;
                    }
                    
                    NSMutableString *result = [NSMutableString stringWithCapacity:[(NSString *)(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j) length]];
                    
                    NSScanner *scanner = [NSScanner scannerWithString:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j)];
                    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
                    
                    while ([scanner isAtEnd] == NO)
                    {
                        NSString *buffer;
                        if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
                        {
                            [result appendString:buffer];
                        }
                        else
                        {
                            [scanner setScanLocation:([scanner scanLocation] + 1)];
                        }
                    }
                    
                    NSString *phone =result;
                    
                    if(phone.length  > 10)
                    {
                        phone = [phone substringFromIndex:MAX((int)[phone length]-10, 0)];
                    }
                    
                    [phoneNos addObject:[self trimStr:phone]];
                    
                }
                
                [dict setValue:phoneNos forKey:@"phone"];
                
                
                if (phoneNos.count > 0) {
                    [contactsArray addObject:dict];
                }
                
            }
            
        }
        
        success(contactsArray);
        
        //8
        CFRelease(addressBook);
    }
}


+(NSString*)trimStr:(NSString*)str
{
    NSString *str1=[[NSString alloc]init];
    str1=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str1;
}
@end
