//
//  UIColor+Scale.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UIColor+Scale.h"

@implementation UIColor (Scale)
/**
 *  将16进制字符串转换成UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}


+ (instancetype)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha:alpha];
}

+ (instancetype)placeholderColor {
    return [UIColor colorWithIntRed:245 green:245 blue:247 alpha:1];
}

+ (instancetype)navDefaultColor {
    return [UIColor colorWithIntRed:45 green:132 blue:242 alpha:1];
}

+ (instancetype)randomColor {
    return  [UIColor colorWithIntRed:arc4random() % 256 green:arc4random() % 256 blue:arc4random() % 256 alpha:1];
}

+ (instancetype)textColor {
    return [UIColor colorWithIntRed:51 green:51 blue:51 alpha:1];
}

+ (instancetype)shallowTextColor {
    return [UIColor colorWithIntRed:179 green:179 blue:179 alpha:1];
}

@end
