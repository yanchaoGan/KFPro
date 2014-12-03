//
//  KFSBHelper.m
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFSBHelper.h"

extern NSDate * calendarViewSelect;

@implementation KFSBHelper

+(void)changeWindowRootVCToAfterLogin:(BOOL)afterlogin orToLoginVC:(BOOL)login{
    
    if ((afterlogin&&login)||(!afterlogin&&!login)) {
        //NSLog(@"逻辑切换错误");
        return;
    }
    
    
    UIViewController *rootVC =nil;
    NSString *storyBoardName =nil;
    
    if (afterlogin) {
        
        if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:NSClassFromString(@"KFMainShowViewController")]) {
            return;
        };
        
        storyBoardName = @"MainShow";
    }
    if (login) {
        if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:NSClassFromString(@"KFLoginViewController")]) {
            return;
        };
        
        
         storyBoardName = @"Main_iPhone";
    
    }

    [UIApplication sharedApplication].keyWindow.rootViewController =nil;
    rootVC = [[UIStoryboard storyboardWithName:storyBoardName bundle:nil]  instantiateInitialViewController];
    
    
    [UIApplication sharedApplication].keyWindow.rootViewController =rootVC;
    
    
    
}



+(BOOL)isNotEmptyStringOfObj:(id)obj{
    BOOL isSring =NO;
    if (obj&&([obj isKindOfClass:[NSString class]])&&((NSString *)obj).length>0) {
        isSring =YES;
    }
    return isSring;
}

+(BOOL)systemVersonIsAfterNumber:(float)number{
    BOOL isAfter =NO;
    isAfter =(([[[UIDevice currentDevice] systemVersion] floatValue] >=number)?(YES):(NO));
    return isAfter;
}

+(BOOL)isIPhone{
    BOOL isPhone =NO;
    isPhone =(([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPhone))?(YES):(NO);
    return isPhone;
}


+(BOOL)isNotEmptyDicObj:(id)obj{

    BOOL isDic = NO;
    if (obj && [obj isKindOfClass:[NSDictionary class]] && [(NSDictionary *)obj allKeys].count >0 && ![obj isEqual:[NSNull null]]) {
        isDic = YES;
    }
    return isDic;
}

+(BOOL)isNotEmptyArrObj:(id)obj{

    BOOL isArr = NO;
    if (obj && [obj isKindOfClass:[NSArray class]] && [(NSArray *)obj count] >0 && ![obj isEqual:[NSNull null]] ) {
        isArr = YES;
    }
    return isArr;
}



+(NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //gyc 2014-12-3 gmt
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];// HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+(NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //gyc 2014-12-3 gmt
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:timeZone];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];// HH:mm:ss zzz"];//
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


+(NSString *)fullstringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //gyc 2014-12-3 gmt
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:timeZone];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// HH:mm:ss zzz"];//
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;

}


+(NSString *)headerStringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //gyc 2014-12-3 gmt
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormatter setTimeZone:timeZone];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"MM月dd日"];// HH:mm:ss zzz"];//
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    NSString * week = [date dayOfWeekTypeByChinese];
    
    destDateString = [destDateString stringByAppendingString:[NSString stringWithFormat:@"  %@",week]];
    
    return destDateString;
}


// 获取unity 时间挫
+ (NSString *)getNowDate
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}


+(NSMutableDictionary *)getParamaByUrlType:(URLTYPE)urltype andOtherParamas:(id)futureObj{
    
    
    @synchronized(self){
        
        NSMutableDictionary * paramas = [NSMutableDictionary dictionary];

    
        NSString * URLTYPE;
        NSString * date = @"";
        
        switch (urltype) {
            case urltypelogin:{
            
                URLTYPE = @"login";
                [paramas  setObject:URLTYPE forKey:@"urltype"];
                
                NSString * username = [futureObj objectForKey:@"username"];
                [paramas setObject:username forKey:@"username"];
                
                NSString * password = [futureObj objectForKey:@"password"];
                [paramas setObject:password forKey:@"password"];
                
                NSString * time = [KFSBHelper getNowDate];
                [paramas setObject:time forKey:@"time"];
                
                
                NSString * sign = [KFSBHelper  getMd5SignStringByArr:@[URLTYPE,username,password,time]];
                [paramas setObject:sign forKey:@"sign"];
                
            }break;
                
            case urltypemonthsummary:
            {
                URLTYPE = @"monthsummary";
                [paramas  setObject:URLTYPE forKey:@"urltype"];
                
            
                date = [self stringFromDate:[futureObj objectForKey:@"date"]];
                [paramas  setObject:date forKey:@"date"];
                
                NSString * time = [KFSBHelper getNowDate];
                [paramas setObject:time forKey:@"time"];
                
                NSString * sign = [KFSBHelper  getMd5SignStringByArr:@[URLTYPE,date,time]];
                
                [paramas setObject:sign forKey:@"sign"];
                
            }
                break;
            case urltypeonedaydetail:{
            
                URLTYPE = @"onedaydetail";
                [paramas  setObject:URLTYPE forKey:@"urltype"];
                
                NSDate * passDate = [futureObj objectForKey:@"date"];
                date = [self stringFromDate:passDate];
                [paramas  setObject:date forKey:@"date"];
                
                
                NSString * time = [KFSBHelper getNowDate];
                [paramas setObject:time forKey:@"time"];
                
                
                NSString * sign = [KFSBHelper  getMd5SignStringByArr:@[URLTYPE,date,time]];
                [paramas setObject:sign forKey:@"sign"];

                
                
            }break;
                
            case urltypeplanlist:{
            
                URLTYPE = @"planList";
                [paramas  setObject:URLTYPE forKey:@"urltype"];
                
                date = [futureObj objectForKey:@"date"];
                [paramas setObject:date forKey:@"date"];
                
                
                NSString * lastrefrshtime = [futureObj objectForKey:@"lastrefrshtime"];
                [paramas setObject:lastrefrshtime forKey:@"lastrefrshtime"];
                
                
                
                NSString * lastloadmoretime = [futureObj objectForKey:@"lastloadmoretime"];
                [paramas setObject:lastloadmoretime forKey:@"lastloadmoretime"];
                
                NSString * clientshowmaxday = [futureObj objectForKey:@"clientshowmaxday"];
                [paramas setObject:clientshowmaxday forKey:@"clientshowmaxday"];
                
                NSString * clientshowminday = [futureObj objectForKey:@"clientshowminday"];
                [paramas setObject:clientshowminday forKey:@"clientshowminday"];
                
                NSString * refreshdirection = [futureObj objectForKey:@"refreshdirection"];
                [paramas setObject:refreshdirection forKey:@"refreshdirection"];
                
                
                NSString * time = [KFSBHelper getNowDate];
                [paramas setObject:time forKey:@"time"];
                
                NSString * sign = [KFSBHelper  getMd5SignStringByArr:@[URLTYPE,date,refreshdirection,time]];
                [paramas setObject:sign forKey:@"sign"];
        
                
                
            }break;
                
            case urltypechangepassword:{
            
                URLTYPE = @"changepassword";
                [paramas  setObject:URLTYPE forKey:@"urltype"];
                
                NSString * userid = [futureObj objectForKey:@"userid"];
                [paramas setObject:userid forKey:@"userid"];
                
                NSString * password = [futureObj objectForKey:@"password"];
                [paramas setObject:password forKey:@"password"];
                
                NSString * time = [KFSBHelper getNowDate];
                [paramas setObject:time forKey:@"time"];
                
                NSString * sign = [KFSBHelper  getMd5SignStringByArr:@[URLTYPE,userid,password,time]];
                [paramas setObject:sign forKey:@"sign"];
            }break;
            case urltypechangeuserphoto:{
            
                URLTYPE = @"changeuserphoto";
                [paramas  setObject:URLTYPE forKey:@"urltype"];
                
                NSString * userid = [futureObj objectForKey:@"userid"];
                [paramas setObject:userid forKey:@"userid"];
                
                NSString * time = [KFSBHelper getNowDate];
                [paramas setObject:time forKey:@"time"];
                
                NSString * sign = [KFSBHelper  getMd5SignStringByArr:@[URLTYPE,userid,time]];
                [paramas setObject:sign forKey:@"sign"];
                
            }break;
                
            default:
                break;
        }
        
         return paramas;
    }
    
   
}

+(NSString *)getUrlStringByParama:(NSMutableDictionary *)param{

    NSString * urltype = [param objectForKey:@"urltype"];
    NSString * urlstring = nil;
    
    if ([urltype  isEqualToString:@"login"]) {
        
        urlstring = @"http://192.168.0.118:8080/GamePlan/xml/login.do";
    
    }else if ([urltype isEqualToString:@"monthsummary"]){
    
          urlstring = @"http://192.168.0.118:8080/GamePlan/xml/calendar.do";
    
    }else if ([urltype isEqualToString:@"onedaydetail"]){
        
        urlstring = @"http://192.168.0.118:8080/GamePlan/xml/day.do";
        
    }else if ([urltype isEqualToString:@"planList"]){
    
        urlstring =@"http://192.168.0.118:8080/GamePlan/xml/week.do";
        
    }else if ([urltype isEqualToString:@"changepassword"]){
    
        urlstring = @"http://192.168.0.118:8080/GamePlan/xml/edit.do";
        
    }else if ([urltype isEqualToString:@"changeuserphoto"]){
    
        urlstring = @"http://192.168.0.118:8080/GamePlan/xml/edit.do";
    }
    
    return urlstring;
}




+(NSString *)getMd5SignStringByArr:(NSArray *)signArr{


    NSString * sign = [NSString string];
    
    for (NSString * subStr in signArr) {

       sign = [sign  stringByAppendingString:subStr];
        
    }
    sign = [sign stringByAppendingString:SignKey];
    sign = [sign md5HexDigest];
    return sign;
}



// 是否是当前月份
+(BOOL)isCurrentMonthByDate:(NSDate *)date{

    BOOL is = NO;
    
    NSDate * now = [NSDate date];
    NSString * nows = [self stringFromDate:now];
    NSArray * nowarr = [nows componentsSeparatedByString:@"-"];
    
    NSString * dates = [self stringFromDate:date];
    NSArray * datearr = [dates componentsSeparatedByString:@"-"];

    if ([(NSString *)nowarr[0]  isEqualToString:datearr[0]] && [(NSString *)nowarr[1] isEqualToString:datearr[1]]) {
        
        is = YES;
    }
    return is;
}



+(BOOL)isWeedendByString:(NSString *)dateString{

    BOOL is = NO;
    
    NSDate * date = [self dateFromString:dateString];
    
    NSString  * week = [date dayOfWeekTypeByChinese];
    if ([week isEqualToString:@"周六"] || [week isEqualToString:@"周日"]) {
        is = YES;
    }
    
    return is;
}

+(int)isEarlyThanNowByString:(NSString *)dateString{

    NSDate * now = [NSDate date];
    
    NSString * nows = [self stringFromDate:now];
    now = [self dateFromString:nows];
    
    
    NSDate * date = [self dateFromString:dateString];
    
    
    int early = 0;
    
    NSTimeInterval interval =  [now timeIntervalSinceDate:date];
    if (interval == 0) {
        early = 0;
    }else if (interval > 0){
    
        early = 1;
    }else{
    
        early = -1;
    }

    return early;
}


+(BOOL)isAfterNowThanOneMonth:(NSString *)oherday{
    
    NSDate * now = [NSDate date];
    NSString * nows = [self stringFromDate:now];
    now = [self dateFromString:nows];
    
    NSDate * date = [self dateFromString:oherday];
    BOOL early = NO;
    
    NSTimeInterval interval =  [now timeIntervalSinceDate:date];
    if (fabs(interval) > (30 * 24 * 60 * 60)) {
        early = YES;
    }
    return early;
    

}


+(void)setCalendarViewSelect:(NSDate *)date{

    calendarViewSelect = date;
}
+(NSDate *)getCalendarViewSelect{

    return calendarViewSelect;
}



+(void)simpleAlertTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil, nil];
    [alert show];
}






+ (BOOL)saveAccount:(KFUser *)account
{
    // 获取doc的目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接保存的路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"HDSDK.data"];
    
    // 存储输入的用户信息
    return  [NSKeyedArchiver archiveRootObject:account toFile:filePath];
    
}

+ (KFUser *)account
{
    
    // 获取doc的目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接保存的路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"HDSDK.data"];
    
    // 获取用户存储信息
    KFUser *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    return account;
}











@end











@implementation NSString (MD5HexDigest)


-(NSString *)md5HexDigest

{
    
    const char *original_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(original_str, strlen(original_str), result);
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
        
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
    
}

-(int)isEarlyThanOtherDateString:(NSString *)otherStr{
    
    NSDate * now = [KFSBHelper dateFromString:self];
    
    NSDate * date = [KFSBHelper dateFromString:otherStr];
    
    
    int early = 0;
    
    NSTimeInterval interval =  [now timeIntervalSinceDate:date];
    if (interval == 0) {
        early = 0;
    }else if (interval > 0){
        
        early = -1;
    }else{
        
        early = 1;
    }
    
    return early;

}


@end

























@implementation NSDate (weekDay)

/**
 * day of week (narrow name)
 */
-(NSString*)dayOfWeek{
    NSDateFormatter *fmtter =[[NSDateFormatter alloc] init] ;
    [fmtter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [fmtter setTimeZone:[NSTimeZone  timeZoneForSecondsFromGMT:0]];
    [fmtter setDateFormat:@"EEE"];
    return [fmtter stringFromDate:self];
}


/**
 * day of week type
 */
-(DayOfWeekType)dayOfWeekType{
    NSString* dayString = [self dayOfWeek];
    if (nil == dayString) {
        return DayOfWeekUnknown;
    }
    
    if ([dayString hasPrefix:@"Mon"]) {
        return DayOfWeekMon;
    }
    if ([dayString hasPrefix:@"Tue"]) {
        return DayOfWeekTue;
    }
    if ([dayString hasPrefix:@"Wed"]) {
        return DayOfWeekWed;
    }
    if ([dayString hasPrefix:@"Thu"]) {
        return DayOfWeekThu;
    }
    if ([dayString hasPrefix:@"Fri"]) {
        return DayOfWeekFri;
    }
    if ([dayString hasPrefix:@"Sat"]) {
        return DayOfWeekSat;
    }
    if ([dayString hasPrefix:@"Sun"]) {
        return DayOfWeekSun;
    }
    
    return DayOfWeekUnknown;
}


-(NSString *)dayOfWeekTypeByChinese{

    DayOfWeekType day = [self dayOfWeekType];
    NSString * oneday = nil;
    switch (day) {
        case DayOfWeekUnknown:
            oneday = @"未知";
            break;
        case DayOfWeekMon:
            oneday = @"周一";
            break;
        case DayOfWeekTue:
            oneday = @"周二";
            break;
            
        case DayOfWeekWed:
            oneday = @"周三";
            break;
            
        case DayOfWeekThu:
            oneday = @"周四";
            break;
        case   DayOfWeekFri:
            oneday = @"周五";
            break;
        case   DayOfWeekSat:
            oneday = @"周六";
            break;
            
        case  DayOfWeekSun:
            oneday = @"周日";
            break;
        default:
            break;
    }
    return oneday;
}



@end
