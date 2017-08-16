
//  UIBarButtonItem+Btn.m
//  BuDeJie
//
//  Created by 李江波 on 16/10/17.
//  Copyright © 2016年 com.520it.www. All rights reserved.
//

#import "UIBarButtonItem+Btn.h"
//#import "BOLcationButton.h"
@implementation UIBarButtonItem (Btn)

+ (UIBarButtonItem *)btnWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 44);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
    UIView *view = [[UIView alloc] initWithFrame:btn.frame];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

+ (UIBarButtonItem *)btnWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:btn.frame];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

//+ (UIBarButtonItem *)btnWithImage:(UIImage *)image location:(NSString *)currentLocation target:(id)target action:(SEL)action {
//    BOLcationButton *btn = [BOLcationButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:image forState:UIControlStateNormal];
//    [btn setTitle:currentLocation forState:UIControlStateNormal];
//    [btn sizeToFit];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    UIView *view = [[UIView alloc] initWithFrame:btn.frame];
//    [view addSubview:btn];
//    return [[UIBarButtonItem alloc] initWithCustomView:view];
//}

+ (UIBarButtonItem *)btnWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:btn.frame];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}
+ (UIBarButtonItem *)btnWithImageOne:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 44);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -85, 0, 0);
    UIView *view = [[UIView alloc] initWithFrame:btn.frame];
    [view addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

@end
