//
//  KFSBHelper.h
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


static NSDate * calendarViewSelect = nil;


#define SignKey @"KFManagerSystem"
#define KServerUrl  @"www.baidu.com"

typedef enum url{
    
    urltypelogin = 100,
    urltypemonthsummary,
    urltypeonedaydetail,
    urltypeplanlist,
    urltypechangepassword
    
}URLTYPE;

@interface KFSBHelper : NSObject



+(void)changeWindowRootVCToAfterLogin:(BOOL)afterlogin orToLoginVC:(BOOL)login;



+(BOOL)isNotEmptyStringOfObj:(id)obj;////是非空字符串

+(BOOL)systemVersonIsAfterNumber:(float)number; //判断版本号 是几之后

+(BOOL)isIPhone;



+(BOOL)isNotEmptyDicObj:(id)obj;// 判断非空字典

+(BOOL)isNotEmptyArrObj:(id)obj; // 判断飞鞚数组




+(NSDate *)dateFromString:(NSString *)dateString;
+(NSString *)stringFromDate:(NSDate *)date;




/* 获取距离1970时间戳*/
+ (NSString *)getNowDate;

+(NSMutableDictionary *)getParamaByUrlType:(URLTYPE)urltype;

+(void)setCalendarViewSelect:(NSDate *)date;
+(NSDate *)getCalendarViewSelect;




// 是否是当前月份
+(BOOL)isCurrentMonthByDate:(NSDate *)date;

+(BOOL)isWeedendByString:(NSString *)dateString;

+(int)isEarlyThanNowByString:(NSString *)dateString;


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





@interface NSString (MD5HexDigest)

-(NSString *) md5HexDigest;

@end

