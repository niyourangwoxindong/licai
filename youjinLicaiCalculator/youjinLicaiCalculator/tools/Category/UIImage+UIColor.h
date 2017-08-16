//
//  UIImage+UIColor.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIColor)

/**
 根据传进来的颜色(默认白色)和透明度，生成一个颜色图片
 */
+ (UIImage *)imageWithAlpha: (CGFloat)alpha;
// 根据传进来的颜色和透明度，生成一个颜色图片
+ (UIImage *)imageWithColor: (UIColor *)aimColor WithAlpha: (CGFloat)alpha;

+ (UIImage *)placeholderImage;
+ (UIImage *)shareImageWithUrl:(NSString *)imageUrl;
+ (UIImage *)imageWithView:(UIView *)view;
+ (UIImage *)imageWithView:(UIView *)view size:(CGSize)size;
+ (UIImage *)shareImageWithView:(UIView *)view;


@end
