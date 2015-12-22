//
//  RequestManager.m
//  Voice
//
//  Created by Kabir Chandoke on 7/8/14.
//  Copyright (c) 2014 Kabir Chandoke. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager
{
  
}
@synthesize requestType;
@synthesize isInternetReachable;

#pragma mark - Send asynchronous request
-(void)asynchronousRequestWithPath:(NSString *)strPath
           requestType:(RequestType)type
                params:(NSDictionary *)dictParams
               timeOut:(NSInteger)timeOut
        includeHeaders:(BOOL)include
          onCompletion:(JSONResponseBlock)completionBlock
{
    
    NSMutableURLRequest *urlRequest = [self requestWithPath:strPath requestType:type timeOut:timeOut includeHeader:include paramsDict:dictParams];
    
    [urlRequest setTimeoutInterval:timeOut];
    
    
    AFHTTPRequestOperationManager *httpOperationManager = [AFHTTPRequestOperationManager manager];
    // Added 21 Sept Gurkaran
    httpOperationManager.requestSerializer.timeoutInterval = 150;
    AFHTTPRequestOperation *requestOperation = [httpOperationManager HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject)
                                                {
                                                    NSLog(@"httpOperation.response.statusCode %ld",(long)operation.response.statusCode);
                                                    NSNumber *statusCode = [NSNumber numberWithLong:(long)operation.response.statusCode];
                                                    completionBlock(statusCode.integerValue,responseObject);
                                                }
                                                                                             failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                                {
                                                    if (operation.responseData)
                                                    {
                                                    NSNumber *statusCode = [NSNumber numberWithLong:(long)operation.response.statusCode];
                                                    //NSLog(@"response :%@",error.userInfo.description);
                                                    //NSLog(@"response : %@",operation.responseString);
                                                    NSError *errorJson;
                                                    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:&errorJson];
                                                    
                                                    completionBlock(statusCode.integerValue,responseDict);
                                                    }
                                                    else
                                                    {
                                                        NSLog(@"Request Timeout");
                                                        //request timeout
//                                                        NSNumber *statusCode = [NSNumber numberWithLong:(long)777];
                                                        
//                                                NSDictionary* responseDict = [NSDictionary dictionaryWithObjectsAndKeys: @"Request timed out.Please try again." , @"message", nil];
//                                                        completionBlock(statusCode.integerValue,responseDict);
                                                        
                                                    }
                                                }];
    
    
    // With reference to http://stackoverflow.com/questions/21978951/does-afhttprequestoperationmanager-run-requests-on-the-operationqueue
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"com.gameplan.networkQueue";
    queue.maxConcurrentOperationCount = 1;
    [queue addOperation:requestOperation];
}

#pragma mark - Send synchronous request

-(void)synchronousRequestWithPath:(NSString *)strPath
                requestType:(RequestType)type
                     params:(NSDictionary *)dictParams
                    timeOut:(NSInteger)timeOut
             includeHeaders:(BOOL)include
               onCompletion:(JSONResponseBlock)completionBlock
{
      NSMutableURLRequest *urlRequest = [self requestWithPath:strPath requestType:type timeOut:timeOut includeHeader:include paramsDict:dictParams];
    [urlRequest setTimeoutInterval:timeOut];
    
    NSError *error = nil;
    
    NSHTTPURLResponse *response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if (!error)
    {
        
        NSNumber *statusCode = [NSNumber numberWithLong:response.statusCode];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        completionBlock(statusCode.intValue,dict);
    }
    else
    {
        NSNumber *statusCode = [NSNumber numberWithLong:response.statusCode];
         completionBlock(statusCode.intValue,nil);
    }
}
#pragma mark - Return URL Request
// Returns an instance of NSMutableURLRequest with specified parameters.
-(NSMutableURLRequest *) requestWithPath:(NSString *)strPath
                             requestType:(RequestType)type
                                 timeOut:(NSInteger)time
                           includeHeader:(BOOL)includeHeaders
                              paramsDict:(NSDictionary *)parameterDictionary
{
    requestType=type;
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@",kServerPortDev,strPath];
    NSURL *requestUrl = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *urlRequest;
    
    if (requestType == RequestTypeGet)
    {
        urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:time];
        [urlRequest setHTTPMethod:@"GET"];
    }
    else if (requestType == RequestTypePost)
    {
        urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:time];
        [urlRequest setHTTPMethod:@"POST"];
    }
    else if(requestType == RequestTypePut)
    {
        urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:time];
        [urlRequest setHTTPMethod:@"PUT"];
    }
    else if(requestType == RequestTypeDelete)
    {
        urlRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:time];
        [urlRequest setHTTPMethod:@"DELETE"];
    }
    
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //include headers if required
    if(includeHeaders)
    {
        // values
        NSString *token=[[NSUserDefaults standardUserDefaults] valueForKey:@"x_auth_token"];
        NSLog(@"Token Is %@",token);
        [urlRequest setValue:token  forHTTPHeaderField:@"x-auth-token"];
    }
    
    // Attach HTTP body if required
    if (parameterDictionary)
    {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameterDictionary
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        [urlRequest setHTTPBody:jsonData];
        
    }

    return urlRequest;
}
@end
