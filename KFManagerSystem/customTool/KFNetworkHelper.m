//
//  KFNetworkHelper.m
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFNetworkHelper.h"
#import "AFNetworking.h"

@implementation KFNetworkHelper


+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailBlock)fail andHUBString:(NSString *)hub{
    
//    [MBProgressHUD showMessage:hub toView:nil];
    
    [[AFHTTPRequestOperationManager  manager]  POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUD];
        
        NSString * state = [responseObject objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            
            id result = [responseObject objectForKey:@"result"];
            success(responseObject);
            
        }else{
        
            NSError * err = [NSError errorWithDomain:@"custom" code:5 userInfo:nil];
            fail(err);
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD hideHUD];
        fail(error);
    }];
    
}
+(void)postFileWithUrl:(NSString *)url filePath:(NSString *)filePath params:(NSDictionary *)params success:(SuccessBlock)success   fail:(FailBlock)fail andHUBString:(NSString *)hub{
    
    [MBProgressHUD showMessage:hub toView:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
    NSURL *filePathUrl = [NSURL fileURLWithPath:filePath];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePathUrl name:@"image" error:nil];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         [MBProgressHUD hideHUD];
        NSLog(@"Success: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUD];
        NSLog(@"Error: %@", error);
    }];


}


@end
