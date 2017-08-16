//
//  BankFinancingView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankFinancingView : UIView
@property (nonatomic ,strong)UITextField *inputTextField;//请输入金额
@property (nonatomic ,strong)UIButton *yearButton;//存款期限的按钮
@property (nonatomic ,strong)UILabel *yearLabel;//年限
@property (nonatomic ,strong)UILabel *zeroLabel;//利率
@property (nonatomic ,strong)UIButton *myButton;//我要理财赚收益
@property (nonatomic ,strong)UILabel *theAmountLabel;//利息(元) 金额
@property (nonatomic ,strong)UILabel *theAmountOfLabel;//本息(元) 金额
@property (nonatomic ,strong)UISegmentedControl *periodSegmentCon;//活期 和 定期
@end
