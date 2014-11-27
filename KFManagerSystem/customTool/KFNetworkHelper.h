//
//  KFNetworkHelper.h
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SuccessBlock)(id responseObject);
typedef void (^FailBlock)(NSError *error);


@interface KFNetworkHelper : NSObject



+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params  success:(SuccessBlock)success   fail:(FailBlock)fail andHUBString:(NSString *)hub;



+(void)postFileWithUrl:(NSString *)url filePath:(NSString *)filePath params:(NSDictionary *)params success:(SuccessBlock)success   fail:(FailBlock)fail andHUBString:(NSString *)hub;

@end
