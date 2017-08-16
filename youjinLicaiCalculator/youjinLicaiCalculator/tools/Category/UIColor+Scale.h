//
//  UIColor+Scale.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/6.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Scale)

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (instancetype)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
+ (instancetype)placeholderColor;
+ (instancetype)navDefaultColor;
+ (instancetype)randomColor;
+ (instancetype)textColor;
+ (instancetype)shallowTextColor;

@end
