//
//  UITabBarItem+Font.m
//  BuDeJie
//
//  Created by 李江波 on 16/10/16.
//  Copyright © 2016年 com.520it.www. All rights reserved.
//

#import "UITabBarItem+Font.h"

@implementation UITabBarItem (Font)
- (void)setupTabBarButtonFont:(UIFont *)font {
    NSMutableDictionary *fontDict = [NSMutableDictionary dictionary];
    fontDict[NSFontAttributeName] = font;
    [self setTitleTextAttributes:fontDict forState:UIControlStateNormal];
}
@end
