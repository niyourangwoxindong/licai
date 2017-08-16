//
//  TheThirdViewController.m
//  youjinLicaiCalculator
//
//  Created by 柚今科技01 on 2017/7/3.
//  Copyright © 2017年 柚今科技01. All rights reserved.
//

#import "TheThirdViewController.h"

@interface TheThirdViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic ,strong) UIButton *button;
@end

@implementation TheThirdViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStairViewDidLoadUINavigationBarTintColor];
    [self imageSetbackgroundAboutNavigationBar];
    self.navigationItem.title = @"风险评估";
    self.tabBarController.tabBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 20, 44);
    [_button setImage:[UIImage imageNamed:@"common_icon_back"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
    self.navigationItem.leftBarButtonItem = leftItem;
    _button.hidden = YES;

    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64-49)];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@mobile/page/investPreferenceBegin.html",BASEWEBURl]]];    
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlstr = [NSString stringWithFormat:@"%@",request.URL];
    if ([urlstr isEqualToString:@"https://www.youjin360.com/mobile/page/investPreferenceBegin.html"])
    {
        _button.hidden = YES;
    }else if ([urlstr isEqualToString:@"https://www.youjin360.com/mobile/page/investPreferenceQuestion.html"])
    {
        _button.hidden = NO;
    }else
    {
        _button.hidden = NO;
    }
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView*)webView
{
    NSLog(@"加载中。。。");
}
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    NSLog(@"加载完成");
}
-(void)webView:(UIWebView*)webView DidFailLoadWithError:(NSError*)error
{
    NSLog(@"加载出错%@",error);
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    if ([self.webView canGoBack]) {

        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
