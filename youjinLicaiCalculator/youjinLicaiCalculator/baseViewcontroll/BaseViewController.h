//
//  BaseViewController.h
//  youjinLicaiCalculator
//
//  Created by 柚今科技01 on 2017/6/21.
//  Copyright © 2017年 柚今科技01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
// 设置一级页面视图加载完成时导航栏背景色
- (void)setStairViewDidLoadUINavigationBarTintColor;
//把图片设置为背景
- (void)imageSetbackgroundAboutNavigationBar;
// 创建导航栏右边的按钮(白色文字)
- (void)createRightBarButtonItemWithTitle:(NSString *)title withMethod:(SEL)method;
// 创建导航栏左边的按钮(图片)
- (void)createLeftBarButtonItemWithImage:(NSString *)imageName withMethod:(SEL)method;
@end
