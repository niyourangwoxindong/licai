//
//  NSDate+Utilities.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/10.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

+ (NSString *)dateStringFromNumber:(NSNumber *)dateNumber {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateNumber doubleValue]/1000];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy‑MM‑dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}

+ (NSString *)dateDescriotion {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}

@end
