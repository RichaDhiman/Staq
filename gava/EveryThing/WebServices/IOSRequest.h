//
//  IOSRequest.h
//  AfnetworkingImplementation
//
//  Created by Sumanpreet on 22/07/14.
//  Copyright (c) 2014 CodeBrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface IOSRequest : NSObject


+(void)postImageMessage : (NSString *)url parameters:(NSDictionary *)dparameters imageData:(NSData *)dimageData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure;

+(void)fetchWebData : (NSString *)url  success: (void (^) (NSDictionary
                                                           *responseStr))success failure: (void (^) (NSError *error))failure ;
+(void)fetchVideoData : (NSString *)url  success: (void (^) (NSDictionary
                                                           *responseStr))success failure: (void (^) (NSError *error))failure ;
+(void)fetchAudioData : (NSString *)url  success: (void (^) (NSDictionary
                                                             *responseStr))success failure: (void (^) (NSError *error))failure ;

+(void)uploadData : (NSString *)url parameters:(NSDictionary *)dparameters imageData:(NSData *)dimageData  success: (void (^) (NSDictionary
                                                           *responseStr))success failure: (void (^) (NSError *error))failure ;
+(void)uploadImage : (NSString *)url parameters:(NSDictionary *)dparameters  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure;

+(void)uploadVideoData : (NSString *)url parameters:(NSDictionary *)dparameters videoData:(NSData *)videoData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure;

+(void)uploadAudioData : (NSString *)url parameters:(NSDictionary *)dparameters audioData:(NSData *)audioData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure;

+(void)fetchWebData1 : (NSString *)url  success: (void (^) (NSData *responseStr))success failure: (void (^) (NSError *error))failure;






+(void)fetchJsonData : (NSString *)urlStr  success :(void (^)(NSDictionary * responseDict))success failure :(void (^)(NSError * error))failure ;







@end
