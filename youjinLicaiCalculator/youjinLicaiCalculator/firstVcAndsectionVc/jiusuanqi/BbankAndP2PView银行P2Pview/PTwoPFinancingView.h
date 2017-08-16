//
//  PTwoPFinancingView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTwoPFinancingView : UIView
@property (nonatomic ,strong)UIButton *lookButton;//查看按钮
@property (nonatomic ,strong)UITextField *inputsTextField;//请输入金额
@property (nonatomic ,strong)NSDateComponents *comp;//获取当前的时间
@property (nonatomic ,strong)UIButton *timeButton;//时间选择的按钮
@property (nonatomic ,strong)UILabel *yearsLabel;//年月日
@property (nonatomic ,strong)UITextField *monthTextField;//理财期限的输入
@property (nonatomic ,strong)UITextField *yearTextField;//利率的输入
@property (nonatomic ,strong)UIButton *dayButton;//360天制
@property (nonatomic ,strong)UIButton *meansButton;//还款方式的按钮
@property (nonatomic ,strong)UILabel *chooseLabel;//请选择
@property (nonatomic ,strong)UITextField *deductionTextField;//抵扣奖励   选填
@property (nonatomic ,strong)UITextField *cashBackTextField;//返现奖励  选填
@property (nonatomic ,strong)UITextField *feeTextField;//管理费选填
@property (nonatomic ,strong)UIButton *myNeedButton;//我要理财赚收益 button
@property (nonatomic ,strong)UISegmentedControl *monthSegmentCon;//月 和 日
@property (nonatomic ,strong)UISegmentedControl *yearSegmentCon;//年 和 日

@property (nonatomic ,strong)UILabel *rateLabel;//实际利率(%) 数字
@property (nonatomic ,strong)UILabel *expectedLabel;//预期收益(元) 数字
//推荐平台
@property (nonatomic ,strong)UIView *tuijianptViewsssss;//推荐平台的view
@property (nonatomic ,strong)UILabel *tuijianptLable;//推荐平台的label
@end
