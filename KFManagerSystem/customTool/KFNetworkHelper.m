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
    
    NSString * urlstring = [KFSBHelper getUrlStringByParama:(NSMutableDictionary *)params];
    
    [[AFHTTPRequestOperationManager  manager]  POST:urlstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUD];
        

        responseObject = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        
        NSString * state = [responseObject objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            
            id result = [responseObject objectForKey:@"result"];
            result = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            
            if (DEBUG) {
                NSLog(@"服务器返回数据是 %@",result);
            }
            success(result);
            
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
    
     NSString * urlstring = [KFSBHelper getUrlStringByParama:(NSMutableDictionary *)params];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSURL *filePathUrl = [NSURL fileURLWithPath:filePath];
    
AFHTTPRequestOperation * af=    [manager POST:urlstring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
      BOOL success =  [formData appendPartWithFileURL:filePathUrl name:@"photoimage" fileName:@"photoimage" mimeType:@"image/png" error:nil];
        NSLog(@"filepath is %d",success);
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         [MBProgressHUD hideHUD];
        NSLog(@"Success: %@", responseObject);
        
        
        NSString * state = [responseObject objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            
            id result = [responseObject objectForKey:@"result"];
             result = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            if (DEBUG) {
                NSLog(@"服务器返回数据是 %@",result);
            }
            success(result);
            
        }else{
            
            NSError * err = [NSError errorWithDomain:@"custom" code:5 userInfo:nil];
            fail(err);
        }
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUD];
        NSLog(@"Error: %@", error);
         fail(error);
    }];
    
    NSLog(@"this is%@",af);


}


@end
