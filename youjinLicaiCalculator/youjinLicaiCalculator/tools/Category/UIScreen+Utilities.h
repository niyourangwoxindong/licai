//
//  UIScreen+Utilities.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/4/28.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    IPhone4,
    IPhone5,
    IPhone6,
    IPhone6p,
}DeviceType;

@interface UIScreen (Utilities)

+ (CGRect)bounds;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (CGFloat)screenScale;
+ (CGFloat)screenRatio;

/**
 * Check the screen to see whether it's 4 inch(iphone 5)
 **/
+ (BOOL)isIPhone4;
+ (BOOL)isIPhone5;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone6p;
+ (BOOL)smallScreen;

+ (DeviceType)deviceTypeJudge;



@end
