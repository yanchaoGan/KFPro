//
//  KFSBHelper.h
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFSBHelper : NSObject



+(void)changeWindowRootVCToAfterLogin:(BOOL)afterlogin orToLoginVC:(BOOL)login;



+(BOOL)isNotEmptyStringOfObj:(id)obj;////是非空字符串

+(BOOL)systemVersonIsAfterNumber:(float)number; //判断版本号 是几之后

+(BOOL)isIPhone;



+(BOOL)isNotEmptyDicObj:(id)obj;// 判断非空字典

+(BOOL)isNotEmptyArrObj:(id)obj; // 判断飞鞚数组


+(NSDate *)dateFromString:(NSString *)dateString;

@end




@interface NSDate (weekDay)


typedef enum {
    DayOfWeekUnknown = 0,
    DayOfWeekMon,
    DayOfWeekTue,
    DayOfWeekWed,
    DayOfWeekThu,
    DayOfWeekFri,
    DayOfWeekSat,
    DayOfWeekSun
}DayOfWeekType;
/**
 * day of week (narrow name)
 */
-(NSString*)dayOfWeek;

/**
 * day of week type
 */
-(DayOfWeekType)dayOfWeekType;


-(NSString *)dayOfWeekTypeByChinese;




@end

