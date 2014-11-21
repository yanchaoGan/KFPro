//
//  KFUser.m
//  KFManagerSystem
//
//  Created by admin on 14-11-21.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFUser.h"

@implementation KFUser

+(instancetype)fillUseDic:(NSDictionary *)dataDic{

    KFUser * obj = [[self alloc] init];
    
    obj.username = [dataDic objectForKey:@"username"];
    obj.nickname = [dataDic objectForKey:@"nickname"];
    obj.userphoto = [dataDic objectForKey:@"userphoto"];
    obj.password = [dataDic objectForKey:@"password"];
    
    
    return obj;
}

@end
