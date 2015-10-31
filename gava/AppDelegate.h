//
//  AppDelegate.h
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Facebook-iOS-SDK/FBSDKCoreKit/FBSDKCoreKit.h>
#import <Facebook-iOS-SDK/FBSDKLoginKit/FBSDKLoginKit.h>
#import <Facebook-iOS-SDK/FBSDKShareKit/FBSDKShareKit.h>
#import <MMMaterialDesignSpinner.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#define AppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@class CEReversibleAnimationController, CEBaseInteractionController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (strong, nonatomic) CEReversibleAnimationController *settingsAnimationController;
@property (strong, nonatomic) CEReversibleAnimationController *navigationControllerAnimationController;
@property (strong, nonatomic) CEBaseInteractionController *navigationControllerInteractionController;
@property (strong, nonatomic) CEBaseInteractionController *settingsInteractionController;

//Loader View
@property(nonatomic,retain)UIActivityIndicatorView *loaderView;

@property(nonatomic,retain)MMMaterialDesignSpinner *spinnerView;
-(void)StartAnimating;
-(void)StopAnimating;
@end

