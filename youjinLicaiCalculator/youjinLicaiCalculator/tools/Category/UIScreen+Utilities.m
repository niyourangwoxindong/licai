//
//  UIScreen+Utilities.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UIScreen+Utilities.h"

#define SCREEN_HEIGHT_iPhone4 480.0f
#define SCREEN_HEIGHT_iPhone5 568.0f
#define SCREEN_HEIGHT_iPhone6 667.0f
#define SCREEN_HEIGHT_iPhone6p 736.0f

@implementation UIScreen (Utilities)


+ (CGRect)bounds {
    return [[self mainScreen] bounds];
}

+ (CGFloat)screenWidth {
    return [[self mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight {
    return [[self mainScreen] bounds].size.height;
}

+ (CGFloat)screenScale {
    return [[UIScreen mainScreen]scale];
}

+ (CGFloat)screenRatio {
    return [UIScreen screenWidth] / [UIScreen screenHeight];
}

+ (BOOL)isIPhone4 {
    return SCREEN_HEIGHT_iPhone4 == [self screenHeight];
}

+ (BOOL)isIPhone5 {
    return SCREEN_HEIGHT_iPhone5 == [self screenHeight];
}

+ (BOOL)isIPhone6 {
    return SCREEN_HEIGHT_iPhone6 == [self screenHeight];
}

+ (BOOL)isIPhone6p {
    return SCREEN_HEIGHT_iPhone6p == [self screenHeight];
}

+ (BOOL)smallScreen {
    return [UIScreen isIPhone4] || [UIScreen isIPhone5];
}

+ (DeviceType)deviceTypeJudge {
    if ([UIScreen isIPhone4]) {
        return IPhone4;
    }
    else if ([UIScreen isIPhone5])
    {
        return IPhone5;
    }
    else if ([UIScreen isIPhone6])
    {
        return IPhone6;
    }
    return IPhone6p;
}


@end
