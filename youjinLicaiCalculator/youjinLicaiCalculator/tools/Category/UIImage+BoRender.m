//
//  UIImage+BoRender.m
//  BuDeJie
//
//  Created by 李江波 on 16/10/16.
//  Copyright © 2016年 com.520it.www. All rights reserved.
//

#import "UIImage+BoRender.h"

@implementation UIImage (BoRender)

+ (UIImage *)renderWithImage:(UIImage *)image {
    UIImage *selImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return selImage;
}
@end
