//
//  YoujinTabBarViewController.m
//  youjinLicaiCalculator
//
//  Created by 柚今科技01 on 2017/6/21.
//  Copyright © 2017年 柚今科技01. All rights reserved.
//

#import "YoujinTabBarViewController.h"
#import "YoujinNavigationController.h"
#import "TheFirstViewController.h"
#import "TheSecondViewController.h"
#import "TheThirdViewController.h"

@interface YoujinTabBarViewController ()

@end

@implementation YoujinTabBarViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加所有的子控制器
    [self addAllChildViewController];
    //设置所有的TabBarButton
    [self setUpAllTabBarButton];
}
#pragma mark - 添加所有的子控制器
- (void)addAllChildViewController
{
    // 1.添加计算控制器
    TheFirstViewController *firstVC = [[TheFirstViewController alloc] init];
    YoujinNavigationController *firstNav = [[YoujinNavigationController alloc] initWithRootViewController:firstVC];
    [self addChildViewController:firstNav];
    // 2.添加风险评估控制器
    TheThirdViewController *thirdVC = [[TheThirdViewController alloc] init];
    YoujinNavigationController *thirdNav = [[YoujinNavigationController alloc] initWithRootViewController:thirdVC];
    [self addChildViewController:thirdNav];
    // 3.添加更多发现控制器
    TheSecondViewController *secondVC = [[TheSecondViewController alloc] init];
    YoujinNavigationController *secondNav = [[YoujinNavigationController alloc] initWithRootViewController:secondVC];
    [self addChildViewController:secondNav];
}
#pragma mark - 添加所有的按钮
- (void)setUpAllTabBarButton
{
    // 1.添加按钮
    YoujinNavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"理财计算";
    nav.tabBarItem.image = [UIImage imageNamed:@"icon_lcjs_nor"];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_lcjs_pre"];
    // 2.添加按钮
    YoujinNavigationController *nav3 = self.childViewControllers[1];
    nav3.tabBarItem.title = @"风险评估";
    nav3.tabBarItem.image = [UIImage imageNamed:@"icon_fxpg_nor"];
    nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_fxpg_pre"];
    // 3.添加按钮
    YoujinNavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"更多发现";
    nav2.tabBarItem.image = [UIImage imageNamed:@"icon_gdfx_nor"];
    nav2.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_gdfx_pre"];
}
@end
