//
//  KFSBHelper.m
//  KFManagerSystem
//
//  Created by admin on 14-11-18.
//  Copyright (c) 2014年 gychao. All rights reserved.
//

#import "KFSBHelper.h"

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
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];// HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}


@end




@implementation NSDate (weekDay)

/**
 * day of week (narrow name)
 */
-(NSString*)dayOfWeek{
    NSDateFormatter *fmtter =[[NSDateFormatter alloc] init] ;
//    [fmtter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
//    [fmtter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
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
