//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by 李江波 on 16/10/17.
//  Copyright © 2016年 com.520it.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 *  x = self.view.frame.origin.x
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  y = self.view.frame.origin.y
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  width = self.view.frame.size.width
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  height = self.view.frame.size.height
 */
@property (nonatomic, assign) CGFloat height;

@property CGFloat centerX;
@property CGFloat centerY;

@property CGFloat top;
@property CGFloat bottom;



- (void)makeCornerWithCornerRadius:(CGFloat)cornerRadius;
- (void)makeCornerBorderWithWidth:(CGFloat)width cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor;
- (void)makeShadowWithShadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowRadius:(CGFloat)shadowRadius shadowOpacity:(float)shadowOpacity shadowPath:(CGPathRef)shadowPath;
- (void)makeDefaultShadowWithShadowPath:(CGPathRef)shadowPath;


@end
