//
//  BaseViewController.m
//  youjinLicaiCalculator
//
//  Created by 柚今科技01 on 2017/6/21.
//  Copyright © 2017年 柚今科技01. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = mainColor;
}

// 设置一级页面视图加载完成时导航栏背景色
- (void)setStairViewDidLoadUINavigationBarTintColor
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:45.0/255 green:131.0/255 blue:240.0/255 alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1],NSForegroundColorAttributeName,nil]];
}
//把图片设置为背景
- (void)imageSetbackgroundAboutNavigationBar
{
    //把颜色转成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] WithAlpha:1];
    //把图片设置为背景
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
// 创建导航栏右边的按钮(文字)
- (void)createRightBarButtonItemWithTitle:(NSString *)title withMethod:(SEL)method
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, 0, 90, 44);
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}
// 创建导航栏左边的按钮(图片)
- (void)createLeftBarButtonItemWithImage:(NSString *)imageName withMethod:(SEL)method
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 44);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}
@end
