//
//  UIImage+UIColor.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/2/7.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UIImage+UIColor.h"
//#import "ImageConpressManager.h"
//#import "ShareWatermarkView.h"

@implementation UIImage (UIColor)




+ (UIImage *)imageWithAlpha: (CGFloat)alpha
{
    //设置背景图片
    //颜色是可以直接生成图片的.
    UIColor *aimColor = [UIColor colorWithWhite:1 alpha:alpha];

    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [aimColor CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithColor: (UIColor *)aimColor WithAlpha: (CGFloat)alpha
{
    //设置背景图片
    //颜色是可以直接生成图片的.
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [aimColor CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

//+ (UIImage *)shareImageWithUrl:(NSString *)imageUrl {
//    id image = nil;
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//    image = [UIImage imageWithData:imageData];
//    if (imageData.length/1024.0 > 10) {
//        NSData *data = [ImageConpressManager compressImage:image PixelCompress:NO MaxPixel:0 JPEGCompress:YES MaxSize_KB:7];
//        image = [UIImage imageWithData:data];
//    }
//    if(!image){
//        image = [UIImage imageNamed:@"AppIcon40x40"];
//    }
//    return image;
//}

+ (UIImage *)placeholderImage {
    return [UIImage imageWithColor:[UIColor colorWithHexString:@"#F5F5F7" alpha:1] WithAlpha:1];
}

+ (UIImage *)imageWithView:(UIView *)view {
    return [UIImage imageWithView:view size:view.frame.size];
}

+ (UIImage *)imageWithView:(UIView *)view size:(CGSize)size {
    if([UIScreen instancesRespondToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] >= 2){
        UIGraphicsBeginImageContextWithOptions(size,NO, 2);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//+ (UIImage *)shareImageWithView:(UIView *)view {
//    UIImage *image = [UIImage imageWithView:view];
//    ShareWatermarkView *shareView = [ShareWatermarkView create];
//    [shareView layoutSubviews];
//    [shareView updateShareImage:image];
//    UIImage *snapImage = [UIImage imageWithView:shareView];
//    return snapImage;
//}

@end
