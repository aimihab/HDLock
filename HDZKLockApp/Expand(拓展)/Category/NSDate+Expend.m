//
//  NSDate+Expend.m
//  BodyScaleBLE
//
//  Created by Jason on 13-1-30.
//  Copyright (c) 2013年 Jason. All rights reserved.
//

#import "NSDate+Expend.h"

@implementation NSDate (Expend)

+(int)getDaysFrom1970:(NSString*)dateString
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:@"1970-1-1"];
    NSDate *date2=[dateFormatter dateFromString:dateString];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int days=((int)time)/(3600*24);
    return days;
}

+(NSDate *)getDateByDayPassedFrom1970:(int)passDays
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:@"1970-1-1"];
    NSDate *date2=[date1 dateByAddingTimeInterval:passDays*3600*24];
    return date2;
}
+(int)getDaysFrom2015:(NSString*)dateString
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:@"2015-1-1"];
    NSDate *date2=[dateFormatter dateFromString:dateString];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int days=((int)time)/(3600*24);
    return days;
}

+(NSDate *)getDateByDayPassedFrom2015:(int)passDays
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:@"2015-1-1"];
    NSDate *date2=[date1 dateByAddingTimeInterval:passDays*3600*24];
    return date2;
}

+(NSDate *)getDateByTimePassedFrom1970:(long long)passTime
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:@"1970-1-1"];
    NSDate *date2=[date1 dateByAddingTimeInterval:passTime];
    return date2;
}

+(int)getCurrentYear
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = DATE_CURRENT;
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int year = (int)[dateComponent year];
    return year;
}

+(int)getCurrentMonth
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = DATE_CURRENT;
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int month = (int)[dateComponent month];
    return month;
}

+(int)getCurrentDay
{
    NSDate *now = [NSDate date];
    NSLog(@"now date is: %@", now);
    NSCalendar *calendar = DATE_CURRENT;
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int day = (int)[dateComponent day];
    return day;
}

+(int)getCurrentHour
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = DATE_CURRENT;
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    return hour;

}

+(int)getCurrentMin
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = DATE_CURRENT;
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int min = (int)[dateComponent minute];
    return min;


}

+(int)getCurrentSecond
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = DATE_CURRENT;
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int second = (int)[dateComponent second];
    return second;
}

+(NSUInteger)getWeekdayFromDate:(NSDate*)date
{
    
    NSCalendar *calendar = DATE_CURRENT;
    
    NSDateComponents* components = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit |
    
    NSMonthCalendarUnit |
    
    NSDayCalendarUnit |
    
    NSWeekdayCalendarUnit |
    
    NSHourCalendarUnit |
    
    NSMinuteCalendarUnit |
    
    NSSecondCalendarUnit;
    
    
    
    components = [calendar components:unitFlags fromDate:date];
    
    NSUInteger weekday = [components weekday];
    
    return weekday;
    
}

-(int)getYear
{
    NSDateComponents *components = [DATE_CURRENT components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    return (int)[components year];
}

-(int)getMon
{
    NSDateComponents *components = [DATE_CURRENT components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    return (int)[components month];
}

-(int)getDay
{
    NSDateComponents *components = [DATE_CURRENT components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    return (int)[components day];
}

-(int)getGeoYear
{
     NSCalendar *gregorian = DATE_CURRENT;
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    return (int)[components year];
}

-(int)getGeoMon
{
    NSCalendar *gregorian = DATE_CURRENT;
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    return (int)[components month];
}

-(int)getGeoDay
{
    NSCalendar *gregorian = DATE_CURRENT;
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    return (int)[components day];
}

-(int)getHour
{
    NSDateComponents *components = [DATE_CURRENT components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit|NSHourCalendarUnit fromDate:self];
    return (int)[components hour];
}

-(int)getMin
{
    NSDateComponents *components = [DATE_CURRENT components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return (int)[components minute];
}

-(int)getSecond
{
    NSDateComponents *components = [DATE_CURRENT components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit |NSSecondCalendarUnit fromDate:self];
    return (int)[components second];
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month

{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:0];
    
    [comps setMonth:month];
    
    [comps setDay:0];
    NSCalendar *calender = DATE_CURRENT;
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mDate;
}

- (NSDateComponents *)componentsOfDay
{
    return [DATE_CURRENT components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
}

- (NSUInteger)year
{
    return [self componentsOfDay].year;
}
- (NSUInteger)month
{
    return [self componentsOfDay].month;
}
- (NSUInteger)day162
{
    return [self componentsOfDay].day;
}
- (NSUInteger)weekday
{
    return [self componentsOfDay].weekday;
}
- (NSUInteger)weekOfDayInYear
{
    return [DATE_CURRENT ordinalityOfUnit:NSWeekOfYearCalendarUnit inUnit:NSYearCalendarUnit forDate:self];
}


- (BOOL)sameWeekWithDate:(NSDate *)otherDate
{
    if (self.year == otherDate.year  && self.month == otherDate.month && self.weekOfDayInYear == otherDate.weekOfDayInYear) {
        return YES;
    } else {
        return NO;
    }
}

+(NSString*)getEngMon:(int)monNum
{
    switch (monNum) {
        case 1:
            return @"Jan";
            break;
        case 2:
            return @"Feb";
            break;
        case 3:
            return @"Mar";
            break;
        case 4:
            return @"Apr";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"Jun";
            break;
        case 7:
            return @"Jul";
            break;
        case 8:
            return @"Aug";
            break;
        case 9:
            return @"Sep";
            break;
        case 10:
            return @"Oct";
            break;
        case 11:
            return @"Nov";
            break;
        case 12:
            return @"Dec";
            break;
        default:
            break;
    }
    return @"";
}

+(NSDate *)dateFromISO8601String:(NSString *)string
{
    if (!string) {
        return nil;
    }
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}

- (NSString *)ISO8601StringWithFormat:(DateFormatType)format
{
    struct tm *timeinfo;
    char buffer[80];
    
    time_t rawtime = [self timeIntervalSince1970];
    timeinfo = localtime(&rawtime);
    switch (format) {
        case DateFormatTypeOne:
            strftime(buffer, 80, "%Y%m%d", timeinfo);
            break;
        case DateFormatTypeTwo:
            strftime(buffer, 80, "%Y%m%d%H%M%S", timeinfo);
            break;
        case DateFormatTypeThree:
            strftime(buffer, 80, "%Y-%m-%d %H:%M:%S", timeinfo);
            break;
        case DateFormatTypeFour:
            strftime(buffer, 80, "%Y%m", timeinfo);
            break;
        default:
            break;
    }
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

-(NSString *)ISO8602String
{
    struct tm *timeinfo;
    char buffer[80];
    
    time_t rawtime = [self timeIntervalSince1970];
    timeinfo = localtime(&rawtime);
    
    strftime(buffer, 80, "%Y%m%d%H%M%S", timeinfo);
    
    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

+ (NSDate *)getDateWithFormat:(NSString *)format andString:(NSString *)string
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateFormat = format;
    dateFormat.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    return [dateFormat dateFromString:string];
}






+ (NSString *)getStringWithFormat:(NSString *)format andDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateFormat = format;
    dateFormat.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    return [dateFormat stringFromDate:date];
}

+ (NSInteger)getCurrentAgeFromBirthdayDate:(NSDate *)date
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [DATE_CURRENT components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateMonth = [components1 month];
    NSInteger brithDateDay   = [components1 day];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [DATE_CURRENT components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateMonth = [components2 month];
    NSInteger currentDateDay   = [components2 day];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return iAge;
}


+ (NSString *)getDayWithDate:(NSDate *)date
{

    NSString *weekString = nil;
    
    switch ([NSDate getWeekdayFromDate:date]) {
        case 2:
        {
            weekString = __LocalizedStringFromKey(@"周一 ");
        }
            break;
        case 3:
        {
            weekString = __LocalizedStringFromKey(@"周二 ");
        }
            break;
        case 4:
        {
            weekString = __LocalizedStringFromKey(@"周三 ");
        }
            break;
        case 5:
        {
            weekString = __LocalizedStringFromKey(@"周四 ");
        }
            break;
        case 6:
        {
            weekString = __LocalizedStringFromKey(@"周五 ");
        }
            break;
        case 7:
        {
            weekString = __LocalizedStringFromKey(@"周六 ");
        }
            break;
        case 1:
        {
            weekString = __LocalizedStringFromKey(@"周日 ");
        }
            break;
        default:
            break;
    }
    if ([[MNLanguageService shareInstance] getCurrentLanguage] == CurrentLanguageTypeChineseSimple ||
        [[MNLanguageService shareInstance] getCurrentLanguage] == CurrentLanguageTypeChineseTraditional) {
        return [NSString stringWithFormat:@"%@ %@",weekString,[self getStringWithFormat:@"MM-dd" andDate:date]];
    }else{
        return [NSString stringWithFormat:@"%@ %@",weekString,[self getStringWithFormat:@"dd/MM" andDate:date]];
    }

}



+ (NSString *)getTimeInfoWithDate:(NSDate *)date
{
    NSString *weekString = nil;
    
    switch ([NSDate getWeekdayFromDate:date]) {
        case 2:
        {
            weekString = __LocalizedStringFromKey(@"周一 ");
        }
            break;
        case 3:
        {
            weekString = __LocalizedStringFromKey(@"周二 ");
        }
            break;
        case 4:
        {
            weekString = __LocalizedStringFromKey(@"周三 ");
        }
            break;
        case 5:
        {
            weekString = __LocalizedStringFromKey(@"周四 ");
        }
            break;
        case 6:
        {
            weekString = __LocalizedStringFromKey(@"周五 ");
        }
            break;
        case 7:
        {
            weekString = __LocalizedStringFromKey(@"周六 ");
        }
            break;
        case 1:
        {
            weekString = __LocalizedStringFromKey(@"周日 ");
        }
            break;
        default:
            break;
    }
    if ([[MNLanguageService shareInstance] getCurrentLanguage] == CurrentLanguageTypeChineseSimple ||
        [[MNLanguageService shareInstance] getCurrentLanguage] == CurrentLanguageTypeChineseTraditional) {
        return [NSString stringWithFormat:@"%@ %@",[self getStringWithFormat:@"yyyy/MM/dd" andDate:date],weekString];
    }else{
        return [NSString stringWithFormat:@"%@ %@",[self getStringWithFormat:@"dd/MM/yyyy" andDate:date],weekString];
    }
}

+ (NSArray *)getWeekRangeArrWithDate:(NSDate *)date
{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = DATE_CURRENT;
    [calendar setFirstWeekday:1];
    
    //“某个时间点”所在的“单元”的起始时间，以及起始时间距离“某个时间点”的时差（单位秒）
    [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:date];
    endDate = [beginDate dateByAddingTimeInterval:interval - 1];
    
    return @[beginDate,endDate];
}

+ (NSArray *)getWeekStartAndEnd:(NSDate *)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:date];
    
    // 获取今天是周几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到今天是几号
    NSInteger day = [comp day];
    
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else{
//        firstDiff = [calendar firstWeekday] - weekDay + 1;
//        lastDiff = 9 - weekDay +1;
        firstDiff = [calendar firstWeekday] - weekDay+1;//原来的
        lastDiff = 8 - weekDay;
    }
    
    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSLog(@"星期一开始 %@",[formater stringFromDate:firstDayOfWeek]);
//    NSLog(@"当前 %@",[formater stringFromDate:date]);
//    NSLog(@"星期天结束 %@",[formater stringFromDate:lastDayOfWeek]);
    return @[firstDayOfWeek,lastDayOfWeek];
}

+(NSInteger )getDayCountOfMonth:(NSString *)month
{
    NSInteger day = 0;
    NSInteger year = [[month substringToIndex:4] integerValue];
    NSInteger mon = [[month substringFromIndex:4] integerValue];
    switch (mon) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day = 30;
            break;
        default:
        {
            if([self isLeapYear:year]){
                day = 29;
            }else{
                day = 28;
            }
        }
            break;
    }
    return day;
}

+ (BOOL)isLeapYear:(NSInteger)year
{
    if ((year % 4  == 0 && year % 100 != 0)  || year % 400 == 0) return YES;
    else return NO;
}

+ (NSDate *)getPreviousDateWithCurrentDate:(NSDate*)date daysLength:(NSInteger)length
{
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - 24 * 3600 * length)];
    return newDate;
}

+ (NSDate *)getNextDateWithCurrentDate:(NSDate *)date daysLength:(NSInteger)length
{
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] + 24 * 3600 * length)];
    return newDate;
}
+(NSString *)holdTime:(NSInteger)time
{
    NSInteger hour = time/60;
    NSInteger minute  = time%60;
    return [NSString stringWithFormat:@"%02ld:%02ld",(long)hour,(long)minute];
}


+(NSInteger)compareDate:(NSString*)date01 withDate:(NSString*)date02
{
    NSInteger ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}

@end