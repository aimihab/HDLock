//
//  NSDate+Expend.h
//  BodyScaleBLE
//
//  Created by Jason on 13-1-30.
//  Copyright (c) 2013年 Jason. All rights reserved.
//

typedef NS_ENUM(NSInteger,DateFormatType)
{
    DateFormatTypeOne, //yyyyMMdd
    DateFormatTypeTwo, //yyyyMMddHHmmss
    DateFormatTypeThree, //yyyy-MM-dd hh:mm:ss
    DateFormatTypeFour, //yyyyMM
};

#import <Foundation/Foundation.h>

@interface NSDate (Expend)

+(int)getDaysFrom1970:(NSString*)dateString;
+(NSDate *)getDateByDayPassedFrom1970:(int)passDays;
+(int)getDaysFrom2015:(NSString*)dateString;
+(NSDate *)getDateByDayPassedFrom2015:(int)passDays;
+(NSDate *)getDateByTimePassedFrom1970:(long long)passTime;
+(int)getCurrentYear;
+(int)getCurrentMonth;
+(int)getCurrentDay;
+(int)getCurrentHour;
+(int)getCurrentMin;
+(int)getCurrentSecond;
+(NSUInteger)getWeekdayFromDate:(NSDate*)date;
-(int)getYear;
-(int)getMon;
-(int)getDay;
-(int)getHour;
-(int)getMin;
-(int)getSecond;
-(int)getGeoYear;
-(int)getGeoMon;
-(int)getGeoDay;
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
- (BOOL)sameWeekWithDate:(NSDate *)otherDate;
+(NSString*)getEngMon:(int)monNum;

+ (NSDate *)dateFromISO8601String:(NSString *)string;
- (NSString *)ISO8601StringWithFormat:(DateFormatType)format;
/**
 *  将字符串转化为NSDate对象
 */
+ (NSDate *)getDateWithFormat:(NSString *)format andString:(NSString *)string;
/**
 *  将NSDate转化为字符串对象
 */
+ (NSString *)getStringWithFormat:(NSString *)format andDate:(NSDate *)date;
/**
 *  将出生年月转化为年龄
 */
+(NSInteger)getCurrentAgeFromBirthdayDate:(NSDate *)date;
/**
 *  获取某天的时间信息 (格式为1990/01/01 周一)
 */
+ (NSString *)getTimeInfoWithDate:(NSDate *)date;
/**
 *  获取某个日期所在星期的时间范围 (数组第一项为周日 第二项为周六)
 */
+ (NSArray *)getWeekRangeArrWithDate:(NSDate *)date;

/**
 *  获取某个日期所在星期的时间范围 (数组第一项为周一 第二项为周日)
 */

+ (NSArray *)getWeekStartAndEnd:(NSDate *)date;

/**
 *  获取某月的总天数
 *
 *  @param month (格式为 yyyyMM)
 */
+(NSInteger)getDayCountOfMonth:(NSString *)month;
/**
 *  获取某个日期前N天的日期
 *
 *  @param date   当前日期
 *  @param length 间隔天数
 */
+ (NSDate *)getPreviousDateWithCurrentDate:(NSDate*)date daysLength:(NSInteger)length;
/**
 *  获取某个日期后N天的日期
 *
 *  @param date   当前日期
 *  @param length 间隔天数
 */
+ (NSDate *)getNextDateWithCurrentDate:(NSDate*)date daysLength:(NSInteger)length;

+(NSString *)holdTime:(NSInteger)time;


/**
 *  比较两个日期的先后
 *
 *  @param date01   日期01
 *  @param date02   日期02
 */
+(NSInteger)compareDate:(NSString*)date01 withDate:(NSString*)date02;


+ (NSString *)getDayWithDate:(NSDate *)date;


@end
