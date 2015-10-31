//
//  IOSRequest.m
//  AfnetworkingImplementation
//
//  Created by Sumanpreet on 22/07/14.
//  Copyright (c) 2014 CodeBrew. All rights reserved.
//

#import "IOSRequest.h"

@implementation IOSRequest

+(void)fetchJsonData : (NSString *)urlStr  success :(void (^)(NSDictionary * responseDict))success failure :(void (^)(NSError * error))failure
{

    
    NSString *urlString  = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString] ;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        
        // Success control
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        success(dict);
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Failure
        
        failure(error);
        
    }];
    
    [operation start];
    

}


+(void)fetchWebData : (NSString *)url  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    // success
        success(responseObject) ;
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // failure
        
        failure(error);
    }];
    
    // 5
    [operation start];
}
+(void)fetchVideoData : (NSString *)url  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"video/mp4"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // success
        success(responseObject) ;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // failure
        
        failure(error);
    }];
    
    // 5
    [operation start];
}

+(void)fetchAudioData : (NSString *)url  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"filename"];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@", path);
        success(responseObject) ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure(error);
    }];
    
    [operation start];
}

//
//+(void)uploadData : (NSString *)url parameters:(NSDictionary *)dparameters imageData:(NSData *)dimageData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
//{
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
//    
//    AFHTTPRequestOperation *op = [manager POST:url parameters:dparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //do not put image inside parameters dictionary as I did, but append it!
//        if (dimageData != nil) {
//                    [formData appendPartWithFileData:dimageData name:@"image" fileName:@"photo11.jpg" mimeType:@"image/jpeg"];
//        }
//
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //success
//      // NSString * str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//    
//        success(dict);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        // failure
//        failure(error);
//    }];
//    
////    op.responseSerializer = [AFHTTPResponseSerializer serializer];
//   op.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [op start];
//
//}


+(void)uploadData : (NSString *)url parameters:(NSDictionary *)dparameters imageData:(NSData *)dimageData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json" ,nil];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:dparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        if (dimageData != nil) {
            [formData appendPartWithFileData:dimageData name:@"image" fileName:@"photo11.jpg" mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success
//         NSString * str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        success(dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
        failure(error);
    }];
    
    //   op.responseSerializer = [AFHTTPResponseSerializer serializer];
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json" ,nil];
    [op start];
    
}


+(void)postImageMessage : (NSString *)url parameters:(NSDictionary *)dparameters imageData:(NSData *)dimageData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:dparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:dimageData name:@"image" fileName:@"photo11.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
        failure(error);
    }];
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [op start];
    
}


+(void)uploadVideoData : (NSString *)url parameters:(NSDictionary *)dparameters videoData:(NSData *)videoData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:dparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:videoData name:@"content" fileName:@"video.mp4" mimeType:@"video/mp4"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
        failure(error);
    }];
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [op start];
    
}

+(void)uploadAudioData : (NSString *)url parameters:(NSDictionary *)dparameters audioData:(NSData *)audioData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:dparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:audioData name:@"content" fileName:@"audio.aac" mimeType:@"audio/aac"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //success
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
        failure(error);
    }];
    op.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [op start];
    
}

+(void)uploadImage : (NSString *)url parameters:(NSDictionary *)dparameters  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *op = [manager POST:url parameters:dparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

    } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSError* error = nil;
        success([NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
    [op start];
    
}

+(void)fetchWebData1 : (NSString *)url  success: (void (^) (NSData *responseStr))success failure: (void (^) (NSError *error))failure
{
    NSString *url1 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url1]];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    operation.responseSerializer =  [AFXMLParserResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // success
        success(responseObject) ;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // failure
        
        failure(error);
    }];
    
    // 5
    [operation start];
}
@end
