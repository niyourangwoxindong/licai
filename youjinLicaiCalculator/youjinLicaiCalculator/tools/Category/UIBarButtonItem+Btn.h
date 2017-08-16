//
//  UIBarButtonItem+Btn.h
//  BuDeJie
//
//  Created by 李江波 on 16/10/17.
//  Copyright © 2016年 com.520it.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Btn)

+ (UIBarButtonItem *)btnWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)btnWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)btnWithImage:(UIImage *)image location:(NSString *)currentLocation target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)btnWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)btnWithImageOne:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
@end
