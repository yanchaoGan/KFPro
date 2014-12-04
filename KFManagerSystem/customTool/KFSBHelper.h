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
    urltypechangepassword,  // 修改密码
    urltypechangeuserphoto  // 上传头像
    
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

+(NSString *)fullstringFromDate:(NSDate *)date;

// use for tableview header
+(NSString *)headerStringFromDate:(NSDate *)date;




/* 获取距离1970时间戳*/
+ (NSString *)getNowDate;

/**
 *  针对不同url 配置参数
 *
 *  @param urltype   接口类型
 *  @param futureObj 需要你传的参数
 *
 *  @return 配置好的参数
 */
+(NSMutableDictionary *)getParamaByUrlType:(URLTYPE)urltype  andOtherParamas:(id)futureObj;


/**
 *  根据 参数接口类型 返回相应的 url 
   这是因为 后台 不能 统一成 接口
 *
 *  @param param
 *
 *  @return
 */
+(NSString *)getUrlStringByParama:(NSMutableDictionary *)param;





+(void)setCalendarViewSelect:(NSDate *)date;
+(NSDate *)getCalendarViewSelect;




// 是否是当前月份
+(BOOL)isCurrentMonthByDate:(NSDate *)date;

+(BOOL)isWeedendByString:(NSString *)dateString;

+(int)isEarlyThanNowByString:(NSString *)dateString;



+(BOOL)isAfterNowThanOneMonth:(NSString *)oherday;





+(void)simpleAlertTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel;





+(NSString *)getTags;




/**
 *  存储数据
 *
 *  @param account 需要存的对象
 *
 *  @return 是否存储成功
 */
+ (BOOL)saveAccount:(KFUser *)account;
/**
 *  获取存储的账号对象
 *
 */
+ (KFUser *)account;



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

/**
 *  当前时间 比 otherstr 时间 早
 *
 *  @param otherStr
 *
 *  @return  0/1/-1
 */
-(int)isEarlyThanOtherDateString:(NSString *)otherStr;

@end

