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


#pragma mark - base64

-(void)setUesrname:(NSString *)useName{
    
    _username = [[useName base64EncodedString] copy];
}

-(NSString *)uesrname{
    
    return [_username base64DecodedString];
}

-(void)setUserpass:(NSString *)userpass1{
    
    _password = [[userpass1 base64EncodedString] copy];
}

-(NSString *)userpass{
    
    return [_password base64DecodedString];
}



#pragma mark - @protocol NSCoding

- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:_username forKey:@"uesrname"];
    [enCoder encodeObject:_password forKey:@"userpass"];
    [enCoder encodeObject:_nickname forKey:@"nickname"];
    [enCoder encodeObject:_userphoto forKey:@"userphoto"];
   

}

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        _username = [decoder decodeObjectForKey:@"uesrname"];
        _password = [decoder decodeObjectForKey:@"userpass"];
        _nickname = [decoder decodeObjectForKey:@"nickname"];
        _userphoto = [decoder decodeObjectForKey:@"userphoto"];
    }
    return self;
    
    
}

@end
