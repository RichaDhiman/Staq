//
//  AlertController+Custom.h
//  gava
//
//  Created by RICHA on 11/23/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController_Custom : UIAlertController

+(UIAlertController *)controllerWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons style:(UIAlertControllerStyle)style success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure;
+(UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons TextField:(NSString *)placeholder success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure;
+(UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure;

+(UIAlertController *)actionSheetWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure;

+(UIAlertController *)alertWithTitle:(NSString *)title buttons:(NSArray *)buttons success: (void (^) (NSString *response))success failure: (void (^) (NSString *error))failure;
+(UIAlertController *)actionSheetWithTitle:(NSString *)title buttons:(NSArray *)buttons keyIfDict:(NSString *)key success: (void (^) (id response))success failure: (void (^) (NSString *error))failure;
+(UIAlertController *)actionSheetWithTitle:(NSString *)title destButtontitle:(NSString *)destTitle buttons:(NSArray *)buttons keyIfDict:(NSString *)key success: (void (^) (id response))success failure: (void (^) (NSString *error))failure;

+(UIAlertController *)successAlertWithTitle:(NSString *)title message:(NSString *)message completion: (void (^) (BOOL completed))success;
+(UIAlertController *)failureAlertWithTitle:(NSString *)title message:(NSString *)message completion: (void (^) (BOOL completed))success;

@end
