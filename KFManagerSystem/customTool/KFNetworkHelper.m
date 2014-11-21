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
    
    [MBProgressHUD showMessage:hub toView:nil];
    
    [[AFHTTPRequestOperationManager  manager]  POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        fail(error);
    }];
    
}

@end