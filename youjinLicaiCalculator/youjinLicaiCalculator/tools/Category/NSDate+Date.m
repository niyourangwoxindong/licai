//
//  NSDate+Date.m
//  BuDeJie19
//
//  Created by xmg5 on 16/10/26.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

#import "NSDate+Date.h"

@implementation NSDate (Date)
- (BOOL)isThisYear
{
    // 获取年份 日历对象（获取日历组件）
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];

    // 获取调用者日期年份
    NSDateComponents *createCmp = [calendar components:NSCalendarUnitYear fromDate:self];
    
    // 获取当前时间
    NSDate *curDate = [NSDate date];
    
    // 获取当前时间日期年份
    NSDateComponents *curCmp = [calendar components:NSCalendarUnitYear fromDate:curDate];
    
    return createCmp.year == curCmp.year;
}

- (BOOL)isThisToday
{
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar isDateInToday:self];
}

- (BOOL)isThisYesterday
{
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];

    return [calendar isDateInYesterday:self];
}

- (NSDateComponents *)detalWithNow
{
    // 获取日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self toDate:[NSDate date] options:NSCalendarWrapComponents];
    
}

@end
