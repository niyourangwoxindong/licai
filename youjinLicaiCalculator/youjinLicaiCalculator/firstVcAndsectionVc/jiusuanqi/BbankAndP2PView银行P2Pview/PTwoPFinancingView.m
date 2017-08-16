//
//  PTwoPFinancingView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PTwoPFinancingView.h"

@implementation PTwoPFinancingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f7" alpha:1];

        [self getsTheCurrentDate];//获取当前年月日
        
        //实际利率(%)  预期收益   还款明细的背景view
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 180*BOScreenH/1334)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        //实际利率(%)  预期收益   还款明细
        NSArray *theActualArr = @[@"实际利率(%)",@"预期收益(元)",@"还款明细"];
        for (int i = 0; i < 3; i ++)
        {
            UILabel *theActualLabel = [[UILabel alloc]initWithFrame:CGRectMake(23*BOScreenW/750 + i*(200*BOScreenW/750+52*BOScreenW/750), 44*BOScreenH/1334, 200*BOScreenW/750, 30*BOScreenH/1334)];
            theActualLabel.text = theActualArr[i];
            theActualLabel.font = [UIFont systemFontOfSize:13];
            theActualLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            theActualLabel.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:theActualLabel];
        }
        //实际利率(%) 数字
        _rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(23*BOScreenW/750 + 0*(200*BOScreenW/750+52*BOScreenW/750), 100*BOScreenH/1334, 200*BOScreenW/750, 40*BOScreenH/1334)];
        _rateLabel.text = @"0";
        [_rateLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        _rateLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _rateLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_rateLabel];
        //预期收益(元) 数字
        _expectedLabel = [[UILabel alloc]initWithFrame:CGRectMake(8*BOScreenW/750 + 1*(200*BOScreenW/750+52*BOScreenW/750), 100*BOScreenH/1334, 220*BOScreenW/750, 40*BOScreenH/1334)];
        _expectedLabel.text = @"0";
        [_expectedLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:23]];
        _expectedLabel.textColor = [UIColor colorWithHexString:@"#ff7b33" alpha:1];
        _expectedLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:_expectedLabel];

        //还款明细  查看
        _lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lookButton.frame = CGRectMake(73*BOScreenW/750 + 2*(200*BOScreenW/750+52*BOScreenW/750), 100*BOScreenH/1334, 100*BOScreenW/750, 40*BOScreenH/1334);
        [_lookButton setTitle:@"查看" forState:UIControlStateNormal];
        _lookButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_lookButton setTitleColor:[UIColor colorWithHexString:@"#2d84f3" alpha:1] forState:UIControlStateNormal];
        [bgView addSubview:_lookButton];
        
        //细线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 179*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [bgView addSubview:lineView];
        
        //请输入理财信息
        UILabel *depositsLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 194*BOScreenH/1334, 400*BOScreenW/750, 40*BOScreenH/1334)];
        depositsLabel.text = @"请输入理财信息";
        [depositsLabel setFont:[UIFont systemFontOfSize:13]];
        depositsLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self addSubview:depositsLabel];
        
        
        //底部的白色的view
        UIView *underTheView = [[UIView alloc]initWithFrame:CGRectMake(0, 248*BOScreenH/1334, BOScreenW, 700*BOScreenH/1334)];
        underTheView.tag = 1000;
        underTheView.backgroundColor = [UIColor whiteColor];
        [self addSubview:underTheView];
        
        NSArray *foreheadArr = @[@"理财金额(元)",@"起息日期",@"理财期限",@"利率"];
        for (int i = 0 ; i < 4; i ++)
        {
            UILabel *foreheadLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334)];
            foreheadLabel.text = foreheadArr[i];
            [foreheadLabel setFont:[UIFont systemFontOfSize:14]];
            foreheadLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            [underTheView addSubview:foreheadLabel];
        }
        //细线
        for (int i = 0; i < 3; i ++)
        {
            UIView *lineView= [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 99*BOScreenH/1334 + i*100*BOScreenH/1334, 720*BOScreenW/750, 1*BOScreenH/1334)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
            [underTheView addSubview:lineView];
        }
        
        //请输入金额
        _inputsTextField = [[UITextField alloc]initWithFrame:CGRectMake(400*BOScreenW/750, 35*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334)];
        _inputsTextField.placeholder = @"请输入实际本金";
        _inputsTextField.textAlignment = NSTextAlignmentRight;
        _inputsTextField.keyboardType = UIKeyboardTypeNumberPad;
        _inputsTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _inputsTextField.font = [UIFont systemFontOfSize:14];
        [underTheView addSubview:_inputsTextField];
        UIToolbar *oneToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *oneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(onecloseKeyboard)];
        oneToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],oneItem];
        _inputsTextField.inputAccessoryView = oneToolbar;

        //1年的箭头
        UIImageView *arrowsImage = [[UIImageView alloc] initWithFrame:CGRectMake(705*BOScreenW/750, 135*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowsImage.image = [UIImage imageNamed:@"common_goto"];
        [underTheView addSubview:arrowsImage];
        
        //年月日
        _yearsLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 135*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
        _yearsLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)_comp.year,(long)_comp.month,(long)_comp.day];
        _yearsLabel.textAlignment = NSTextAlignmentRight;
        [_yearsLabel setFont:[UIFont systemFontOfSize:14]];
        _yearsLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [underTheView addSubview:_yearsLabel];
        //选择时间的按钮
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeButton.frame = CGRectMake(0, 100*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
        [underTheView addSubview:_timeButton];

        //月 和 日
        _monthSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"月", @"日"]];
        _monthSegmentCon.frame = CGRectMake(558*BOScreenW/750, 221*BOScreenH/1334, 162*BOScreenW/750, 58*BOScreenH/1334);
        _monthSegmentCon.selectedSegmentIndex = 0;
        _monthSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [underTheView addSubview:_monthSegmentCon];
        
        //输入
        _monthTextField = [[UITextField alloc]initWithFrame:CGRectMake(398*BOScreenW/750, 221*BOScreenH/1334, 140*BOScreenW/750, 58*BOScreenH/1334)];
        _monthTextField.placeholder = @"输入";
        _monthTextField.textAlignment = NSTextAlignmentCenter;
        _monthTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _monthTextField.font = [UIFont systemFontOfSize:14];
        _monthTextField.layer.borderWidth = 1;
        _monthTextField.layer.borderColor = [UIColor colorWithHexString:@"#dadde0" alpha:1].CGColor;
        _monthTextField.layer.cornerRadius = 4;
        _monthTextField.layer.masksToBounds = YES;
        _monthTextField.keyboardType = UIKeyboardTypeNumberPad;
        [underTheView addSubview:_monthTextField];
        UIToolbar *twoToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *twoItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(twocloseKeyboard)];
        twoToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],twoItem];
        _monthTextField.inputAccessoryView = twoToolbar;
    
        //年 和 日
        _yearSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"年", @"日"]];
        _yearSegmentCon.frame = CGRectMake(558*BOScreenW/750, 321*BOScreenH/1334, 162*BOScreenW/750, 58*BOScreenH/1334);
        _yearSegmentCon.selectedSegmentIndex = 0;
        _yearSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [underTheView addSubview:_yearSegmentCon];
        
        //输入
        _yearTextField = [[UITextField alloc]initWithFrame:CGRectMake(378*BOScreenW/750, 321*BOScreenH/1334, 140*BOScreenW/750, 58*BOScreenH/1334)];
        _yearTextField.placeholder = @"输入";
        _yearTextField.textAlignment = NSTextAlignmentCenter;
        _yearTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _yearTextField.font = [UIFont systemFontOfSize:14];
        _yearTextField.layer.borderWidth = 1;
        _yearTextField.layer.borderColor = [UIColor colorWithHexString:@"#dadde0" alpha:1].CGColor;
        _yearTextField.layer.cornerRadius = 4;
        _yearTextField.layer.masksToBounds = YES;
        _yearTextField.keyboardType = UIKeyboardTypeNumberPad;
        [underTheView addSubview:_yearTextField];
        UIToolbar *threeToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *threeItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(threecloseKeyboard)];
        threeToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],threeItem];
        _yearTextField.inputAccessoryView = threeToolbar;
        
        //%
        UILabel *baifenhaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(518*BOScreenW/750, 321*BOScreenH/1334, 40*BOScreenW/750, 58*BOScreenH/1334)];
        baifenhaoLabel.text = @"%";
        [baifenhaoLabel setFont:[UIFont systemFontOfSize:14]];
        baifenhaoLabel.textAlignment = NSTextAlignmentCenter;
        baifenhaoLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [underTheView addSubview:baifenhaoLabel];
        
        //360天制
        _dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dayButton.frame = CGRectMake(184*BOScreenW/750, 321*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
        if (iPhone5)
        {
             _dayButton.frame = CGRectMake(184*BOScreenW/750, 321*BOScreenH/1334, 185*BOScreenW/750, 58*BOScreenH/1334);
        }
        [_dayButton setImage:[UIImage imageNamed:@"icon_select_nor"] forState:UIControlStateNormal];
//        [_dayButton setImage:[UIImage imageNamed:@"icon_selectsmall_pre"] forState:UIControlStateHighlighted];
        [_dayButton setTitle:@" 360天制" forState:UIControlStateNormal];
        [_dayButton setTitleColor:[UIColor colorWithHexString:@"#737373" alpha:1] forState:UIControlStateNormal];
        [_dayButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _dayButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [underTheView addSubview:_dayButton];

        
        
        _tuijianptViewsssss = [[UIView alloc]initWithFrame:CGRectMake(0, 400*BOScreenH/1334, BOScreenW, 40*BOScreenH/1334)];
        _tuijianptViewsssss.backgroundColor = [UIColor colorWithHexString:@"#fff6f0" alpha:1];
        [underTheView addSubview:_tuijianptViewsssss];
        
        _tuijianptLable = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 0, 690*BOScreenW/750, 40*BOScreenH/1334)];
//        _tuijianptLable.text = @"55555555555555555555555";
        _tuijianptLable.textColor = [UIColor colorWithHexString:@"#ff7b33" alpha:1];
        _tuijianptLable.font = [UIFont systemFontOfSize:12];
        [_tuijianptViewsssss addSubview:_tuijianptLable];
        
        NSArray *threeArr = @[@"还款方式",@"返现奖励",@"管理费(%)"];
        for (int i = 0 ; i < 3; i ++)
        {
            UILabel *threeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + i*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334)];
            threeLabel.tag = 20+i;
            threeLabel.text = threeArr[i];
            [threeLabel setFont:[UIFont systemFontOfSize:14]];
            threeLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            [underTheView addSubview:threeLabel];
        }
        //细线
        for (int i = 0; i < 3; i ++)
        {
            UIView *threelineView= [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + i*100*BOScreenH/1334, 720*BOScreenW/750, 1*BOScreenH/1334)];
            threelineView.tag = 30+i;
            threelineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
            [underTheView addSubview:threelineView];
        }
        
        //请选择的箭头
        UIImageView *arrowssImage = [[UIImageView alloc] initWithFrame:CGRectMake(705*BOScreenW/750, 435*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowssImage.tag = 1001;
        arrowssImage.image = [UIImage imageNamed:@"common_goto"];
        [underTheView addSubview:arrowssImage];
        
        //请选择
        _chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 435*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
        _chooseLabel.text = @"按月付息到期还本";
        _chooseLabel.textAlignment = NSTextAlignmentRight;
        [_chooseLabel setFont:[UIFont systemFontOfSize:14]];
        _chooseLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [underTheView addSubview:_chooseLabel];
        
        //还款方式的按钮
        _meansButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _meansButton.frame = CGRectMake(0, 400*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
        [underTheView addSubview:_meansButton];
        
        //返现奖励  选填
        _cashBackTextField = [[UITextField alloc]initWithFrame:CGRectMake(160*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334)];
        if (iPhone5)
        {
            _cashBackTextField.frame = CGRectMake(180*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
        }
        _cashBackTextField.placeholder = @"选填";
        _cashBackTextField.textAlignment = NSTextAlignmentCenter;
        _cashBackTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _cashBackTextField.font = [UIFont systemFontOfSize:14];
        _cashBackTextField.layer.borderWidth = 1;
        _cashBackTextField.layer.borderColor = [UIColor colorWithHexString:@"#dadde0" alpha:1].CGColor;
        _cashBackTextField.layer.cornerRadius = 4;
        _cashBackTextField.layer.masksToBounds = YES;
        _cashBackTextField.keyboardType = UIKeyboardTypeNumberPad;
        [underTheView addSubview:_cashBackTextField];
        UIToolbar *fourToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *fourItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(fourcloseKeyboard)];
        fourToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],fourItem];
        _cashBackTextField.inputAccessoryView = fourToolbar;


        
        //抵扣奖励   选填
        _deductionTextField = [[UITextField alloc]initWithFrame:CGRectMake(540*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334)];
        _deductionTextField.placeholder = @"选填";
        _deductionTextField.textAlignment = NSTextAlignmentCenter;
        _deductionTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _deductionTextField.font = [UIFont systemFontOfSize:14];
        _deductionTextField.layer.borderWidth = 1;
        _deductionTextField.layer.borderColor = [UIColor colorWithHexString:@"#dadde0" alpha:1].CGColor;
        _deductionTextField.layer.cornerRadius = 4;
        _deductionTextField.layer.masksToBounds = YES;
        _deductionTextField.keyboardType = UIKeyboardTypeNumberPad;
        [underTheView addSubview:_deductionTextField];
        UIToolbar *fiveToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *fiveItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(fivecloseKeyboard)];
        fiveToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],fiveItem];
        _deductionTextField.inputAccessoryView = fiveToolbar;
        
        //抵扣奖励
        UILabel *deducLabel = [[UILabel alloc]initWithFrame:CGRectMake(370*BOScreenW/750, 521*BOScreenH/1334, 150*BOScreenW/750, 58*BOScreenH/1334)];
        deducLabel.tag = 1003;
        deducLabel.text = @"抵扣奖励";
        deducLabel.textAlignment = NSTextAlignmentRight;
        [deducLabel setFont:[UIFont systemFontOfSize:14]];
        deducLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [underTheView addSubview:deducLabel];
        
        //管理费选填
        _feeTextField = [[UITextField alloc]initWithFrame:CGRectMake(400*BOScreenW/750, 635*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334)];
        _feeTextField.placeholder = @"管理费选填";
        _feeTextField.textAlignment = NSTextAlignmentRight;
        _feeTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _feeTextField.font = [UIFont systemFontOfSize:14];
        _feeTextField.keyboardType = UIKeyboardTypeNumberPad;
        [underTheView addSubview:_feeTextField];
        UIToolbar *sixToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *sixItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(sixcloseKeyboard)];
        sixToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],sixItem];
        _feeTextField.inputAccessoryView = sixToolbar;

        
        //我要理财赚收益 button
        _myNeedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _myNeedButton.frame = CGRectMake(135*BOScreenW/750, 978*BOScreenH/1334, 480*BOScreenW/750, 0*BOScreenH/1334);
        [_myNeedButton setTitle:@"我要理财赚收益" forState:UIControlStateNormal];
        [_myNeedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _myNeedButton.titleLabel.font  = [UIFont systemFontOfSize:15];
        _myNeedButton.backgroundColor = [UIColor colorWithHexString:@"#ffa238" alpha:1];
        _myNeedButton.layer.cornerRadius = 20;
        if (iPhone6P)
        {
            _myNeedButton.layer.cornerRadius = 23;
        }
        if (iPhone5)
        {
            _myNeedButton.layer.cornerRadius = 17;
        }
        _myNeedButton.layer.masksToBounds = YES;
        [self addSubview:_myNeedButton];
    }
    return self;
}
//理财金额
- (void)underButtonClick
{
    [_inputsTextField resignFirstResponder];
}
//理财期限
- (void)oneunderButtonClick
{
    [_monthTextField resignFirstResponder];
}
//利率
- (void)twounderButtonClick
{
    [_yearTextField resignFirstResponder];
}
////360天制
//- (void)dayButtonClick:(UIButton *)sender
//{
//    if (sender.selected)
//    {
//        [_dayButton setImage:[UIImage imageNamed:@"icon_selectsmall_nor"] forState:UIControlStateNormal];
//        sender.selected = NO;
//    }else
//    {
//        [_dayButton setImage:[UIImage imageNamed:@"icon_selectsmall_pre"] forState:UIControlStateNormal];
//        sender.selected = YES;
//    }
//}
#pragma mark---获取当前的年月日---
- (void)getsTheCurrentDate
{
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    // 获取不同时间字段的信息
    _comp = [gregorian components: unitFlags fromDate:dt];
}
- (void)onecloseKeyboard
{
    [_inputsTextField resignFirstResponder];
}
- (void)twocloseKeyboard
{
    [_monthTextField resignFirstResponder];
}
- (void)threecloseKeyboard
{
    [_yearTextField resignFirstResponder];
}
- (void)fourcloseKeyboard
{
    [_cashBackTextField resignFirstResponder];
}
- (void)fivecloseKeyboard
{
    [_deductionTextField resignFirstResponder];
}
- (void)sixcloseKeyboard
{
    [_feeTextField resignFirstResponder];
}
@end
