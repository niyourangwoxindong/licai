//
//  ChakanViewController.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ChakanViewController.h"
#import "ChakanTableViewCell.h"

@interface ChakanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UIView *zeroView;//第零区的view
@property (nonatomic ,strong)UIView *firstView;//第一区的view
@end

@implementation ChakanViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createLeftBarButtonItemWithImage:@"common_icon_back" withMethod:@selector(leftBarButtonItemClick)];
    self.title = @"还款明细";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    [self zerothView];//第零区的view
    [self theFirstView];//第一区的view
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return [_qishuString intValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    ChakanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[ChakanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    //根据不同的区改变背景图片
    if (indexPath.row%2)
    {
        cell.backgroundColor = [UIColor colorWithHexString:@"#fcfcfc" alpha:1];
    }else
    {
        cell.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:1];
    }
    cell.qishuLabel.text = _qishuArray[indexPath.row];
    cell.benjinLabel.text = _benjinArray[indexPath.row];
    cell.lixiLabel.text = _lixiArray[indexPath.row];
    cell.hkriqiLabel.text = _timeendArray[indexPath.row];
    //点击后的阴影效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 265*BOScreenH/1334;
    }
    return 68*BOScreenH/1334;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _zeroView;
    }
    return _firstView;
}
//第零区的view
- (void)zerothView
{
    _zeroView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 265*BOScreenH/1334)];
    _zeroView.backgroundColor = [UIColor whiteColor];
    
    UILabel *bjLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 38*BOScreenH/1334, 340*BOScreenW/750, 40*BOScreenH/1334)];
//    bjLabel.text = @"本金: 1000";
    bjLabel.text = [NSString stringWithFormat:@"本金: %@",self.benjinString];
    bjLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [self label:bjLabel bubian:@"本金: " bian:self.benjinString];
    bjLabel.font = [UIFont systemFontOfSize:15];
    [_zeroView addSubview:bjLabel];
    
    UILabel *yqLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 105*BOScreenH/1334, 340*BOScreenW/750, 40*BOScreenH/1334)];
//    yqLabel.text = @"预期收益: 1000";
    yqLabel.text = [NSString stringWithFormat:@"预期收益: %@",self.yuqishouyiString];
    yqLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [self label:yqLabel bubian:@"预期收益: " bian:self.yuqishouyiString];
    yqLabel.font = [UIFont systemFontOfSize:15];
    [_zeroView addSubview:yqLabel];
    
    UILabel *qsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 172*BOScreenH/1334, 340*BOScreenW/750, 40*BOScreenH/1334)];
//    qsLabel.text = @"期数: 1000";
    qsLabel.text = [NSString stringWithFormat:@"期数: %@",self.qishuString];
    qsLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [self label:qsLabel bubian:@"期数: " bian:self.qishuString];
    qsLabel.font = [UIFont systemFontOfSize:15];
    [_zeroView addSubview:qsLabel];
    
    UILabel *lxLabel = [[UILabel alloc]initWithFrame:CGRectMake(386*BOScreenW/750, 38*BOScreenH/1334, 340*BOScreenW/750, 40*BOScreenH/1334)];
//    lxLabel.text = @"利息: 1000";
    lxLabel.text = [NSString stringWithFormat:@"利息: %@",self.lixiString];
    lxLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [self label:lxLabel bubian:@"利息: " bian:self.lixiString];
    lxLabel.font = [UIFont systemFontOfSize:15];
    [_zeroView addSubview:lxLabel];
    
    UILabel *nhLabel = [[UILabel alloc]initWithFrame:CGRectMake(386*BOScreenW/750, 105*BOScreenH/1334, 340*BOScreenW/750, 40*BOScreenH/1334)];
//    nhLabel.text = @"年化: 1000";
    NSString *jiabaifenhao = [NSString stringWithFormat:@"%@%@",self.nianhuaString,@"%"];
    nhLabel.text = [NSString stringWithFormat:@"年化: %@",jiabaifenhao];
    nhLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [self label:nhLabel bubian:@"年化: " bian:jiabaifenhao];
    nhLabel.font = [UIFont systemFontOfSize:15];
    [_zeroView addSubview:nhLabel];
    
    UILabel *dqLabel = [[UILabel alloc]initWithFrame:CGRectMake(386*BOScreenW/750, 172*BOScreenH/1334, 340*BOScreenW/750, 40*BOScreenH/1334)];
//    dqLabel.text = @"到期时间: 2017.12.18";
    dqLabel.text = [NSString stringWithFormat:@"到期时间: %@",self.daoqishijianString];
    dqLabel.textColor = [UIColor colorWithHexString:@"#737373" alpha:1];
    [self label:dqLabel bubian:@"到期时间: " bian:self.daoqishijianString];
    dqLabel.font = [UIFont systemFontOfSize:15];
    [_zeroView addSubview:dqLabel];
}
//第一区的view
- (void)theFirstView
{
    _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 68*BOScreenH/1334)];
    _firstView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5" alpha:1];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 1*BOScreenH/1334)];
    lineview.backgroundColor = [UIColor colorWithHexString:@"#e4e8eb" alpha:1];
    [_firstView addSubview:lineview];
    
    UILabel *qishuLabels = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110*BOScreenW/750, 68*BOScreenH/1334)];
    qishuLabels.text = @"期数";
    qishuLabels.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    qishuLabels.font = [UIFont systemFontOfSize:13];
    qishuLabels.textAlignment = NSTextAlignmentCenter;
    [_firstView addSubview:qishuLabels];
    
    UILabel *benjinLabels = [[UILabel alloc]initWithFrame:CGRectMake(164*BOScreenW/750, 0, 150*BOScreenW/750, 68*BOScreenH/1334)];
    benjinLabels.text = @"本金";
    benjinLabels.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    benjinLabels.font = [UIFont systemFontOfSize:13];
    benjinLabels.textAlignment = NSTextAlignmentCenter;
    [_firstView addSubview:benjinLabels];
    
    UILabel *lixiLabels = [[UILabel alloc]initWithFrame:CGRectMake(346*BOScreenW/750, 0, 160*BOScreenW/750, 68*BOScreenH/1334)];
    lixiLabels.text = @"利息";
    lixiLabels.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    lixiLabels.font = [UIFont systemFontOfSize:13];
    lixiLabels.textAlignment = NSTextAlignmentCenter;
    [_firstView addSubview:lixiLabels];
    
    UILabel *hkriqiLabels = [[UILabel alloc]initWithFrame:CGRectMake(510*BOScreenW/750, 0, 220*BOScreenW/750, 68*BOScreenH/1334)];
    hkriqiLabels.text = @"还款日期";
    hkriqiLabels.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    hkriqiLabels.font = [UIFont systemFontOfSize:13];
    hkriqiLabels.textAlignment = NSTextAlignmentCenter;
    [_firstView addSubview:hkriqiLabels];
    
    UIView *lineviews = [[UIView alloc]initWithFrame:CGRectMake(0, 67*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineviews.backgroundColor = [UIColor colorWithHexString:@"#e4e8eb" alpha:1];
    [_firstView addSubview:lineviews];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//字体显示两种颜色
- (void)label:(UILabel *)label bubian:(NSString *)str bian:(NSString *)string
{
    NSMutableAttributedString *twonoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str,string]];
    NSRange tworedRangeTwo = NSMakeRange([[twonoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",string]].location, [[twonoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",string]].length);
    [twonoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333" alpha:1] range:tworedRangeTwo];
    [label setAttributedText:twonoteStr];
    [label sizeToFit];
}
@end
