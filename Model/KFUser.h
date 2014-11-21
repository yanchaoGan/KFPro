//
//  KFUser.h
//  KFManagerSystem
//
//  Created by admin on 14-11-21.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFUser : NSObject


@property (nonatomic,strong)NSString * username;
@property (nonatomic,strong)NSString * nickname;
@property (nonatomic,strong)NSString * userphoto;
@property (nonatomic,strong)NSString * password;



+(instancetype)fillUseDic:(NSDictionary *)dataDic;



@end
