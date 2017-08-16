//
//  BankFinancingView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/3/20.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "BankFinancingView.h"

@implementation BankFinancingView

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
        
        
        //两个本息下面的白色view
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 320*BOScreenH/1334)];
        topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topView];
        
        //利息(元)  本息(元)
        NSArray *interestArr = @[@"利息(元)",@"本息(元)"];
        for (int i = 0; i < 2; i ++)
        {
            UILabel *interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(295*BOScreenW/750, 45*BOScreenH/1334+i*140*BOScreenH/1334, 160*BOScreenW/750, 30*BOScreenH/1334)];
            interestLabel.text = interestArr[i];
            interestLabel.textAlignment = NSTextAlignmentCenter;
            interestLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            interestLabel.font = [UIFont systemFontOfSize:14];
            [topView addSubview:interestLabel];
            if (i == 1)
            {
                interestLabel.font = [UIFont systemFontOfSize:13];
            }
        }
        
        //利息(元) 金额
        _theAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(175*BOScreenW/750, 105*BOScreenH/1334, 400*BOScreenW/750, 55*BOScreenH/1334)];
        _theAmountLabel.text = @"0";
        _theAmountLabel.textAlignment = NSTextAlignmentCenter;
        [_theAmountLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        _theAmountLabel.textColor = [UIColor colorWithHexString:@"#ff7b33" alpha:1];
        [topView addSubview:_theAmountLabel];
        
        //本息(元) 金额
        _theAmountOfLabel = [[UILabel alloc]initWithFrame:CGRectMake(175*BOScreenW/750, 235*BOScreenH/1334, 400*BOScreenW/750, 55*BOScreenH/1334)];
        _theAmountOfLabel.text = @"0";
        _theAmountOfLabel.textAlignment = NSTextAlignmentCenter;
        [_theAmountOfLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        _theAmountOfLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [topView addSubview:_theAmountOfLabel];
        
        //细线
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 319*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        [topView addSubview:lineView];
        
        
        //请输入存款信息
        UILabel *depositLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 334*BOScreenH/1334, 400*BOScreenW/750, 40*BOScreenH/1334)];
        depositLabel.text = @"请输入存款信息";
        [depositLabel setFont:[UIFont systemFontOfSize:13]];
        depositLabel.textColor = [UIColor colorWithHexString:@"#999999" alpha:1];
        [self addSubview:depositLabel];
        
        
        //存款。。。年利率view
        UIView *followingView = [[UIView alloc]initWithFrame:CGRectMake(0, 388*BOScreenH/1334, BOScreenW, 400*BOScreenH/1334)];
        followingView.backgroundColor = [UIColor whiteColor];
        [self addSubview:followingView];
        
        NSArray *saveArr = @[@"存款金额(元)",@"存款类型",@"存款期限",@"年利率(%)"];
        for (int i = 0 ; i < 4; i ++)
        {
            UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 35*BOScreenH/1334 + i*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334)];
            saveLabel.text = saveArr[i];
            [saveLabel setFont:[UIFont systemFontOfSize:14]];
            saveLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
            [followingView addSubview:saveLabel];
        }
        //细线
        for (int i = 0; i < 3; i ++)
        {
            UIView *lineView= [[UIView alloc]initWithFrame:CGRectMake(30*BOScreenW/750, 99*BOScreenH/1334 + i*100*BOScreenH/1334, 720*BOScreenW/750, 1*BOScreenH/1334)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
            [followingView addSubview:lineView];
        }
        //请输入金额
        _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(400*BOScreenW/750, 35*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334)];
        _inputTextField.placeholder = @"请输入金额";
        _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        _inputTextField.textAlignment = NSTextAlignmentRight;
        _inputTextField.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _inputTextField.font = [UIFont systemFontOfSize:14];
        [followingView addSubview:_inputTextField];
        UIToolbar *sixToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, BOScreenW, 44)];
        UIBarButtonItem *sixItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(sixcloseKeyboard)];
        sixToolbar.items = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],sixItem];
        _inputTextField.inputAccessoryView = sixToolbar;

        
        //活期 和 定期
        _periodSegmentCon = [[UISegmentedControl alloc] initWithItems:@[@"活期", @"定期"]];
        _periodSegmentCon.frame = CGRectMake(558*BOScreenW/750, 121*BOScreenH/1334, 162*BOScreenW/750, 58*BOScreenH/1334);
        _periodSegmentCon.selectedSegmentIndex = 0;
        _periodSegmentCon.tintColor = [UIColor colorWithHexString:@"#4697fb" alpha:1];
        [followingView addSubview:_periodSegmentCon];
        
        //1年的箭头
        UIImageView *arrowsImage = [[UIImageView alloc] initWithFrame:CGRectMake(705*BOScreenW/750, 135*BOScreenH/1334 + 100*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334)];
        arrowsImage.image = [UIImage imageNamed:@"common_goto"];
        [followingView addSubview:arrowsImage];
        
        //1年
        _yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(380*BOScreenW/750, 135*BOScreenH/1334 + 100*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
        _yearLabel.text = @"1年";
        _yearLabel.textAlignment = NSTextAlignmentRight;
        [_yearLabel setFont:[UIFont systemFontOfSize:14]];
        _yearLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [followingView addSubview:_yearLabel];
        
        //存款期限的按钮
        _yearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _yearButton.frame = CGRectMake(0, 200*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
        [followingView addSubview:_yearButton];
        
        //0.35
        _zeroLabel = [[UILabel alloc]initWithFrame:CGRectMake(405*BOScreenW/750, 135*BOScreenH/1334 + 200*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334)];
        _zeroLabel.text = @"0.35";
        _zeroLabel.textAlignment = NSTextAlignmentRight;
        [_zeroLabel setFont:[UIFont systemFontOfSize:14]];
        _zeroLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [followingView addSubview:_zeroLabel];
        
        //我要理财赚收益 button
        _myButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _myButton.frame = CGRectMake(135*BOScreenW/750, 828*BOScreenH/1334, 480*BOScreenW/750, 80*BOScreenH/1334);
        [_myButton setTitle:@"我要理财赚收益" forState:UIControlStateNormal];
        [_myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _myButton.titleLabel.font  = [UIFont systemFontOfSize:15];
        _myButton.backgroundColor = [UIColor colorWithHexString:@"#ffa238" alpha:1];
        _myButton.layer.cornerRadius = 20;
        if (iPhone6P)
        {
            _myButton.layer.cornerRadius = 23;
        }
        if (iPhone5)
        {
            _myButton.layer.cornerRadius = 17;
        }
        _myButton.layer.masksToBounds = YES;
        [self addSubview:_myButton];

    }
    return self;
}
- (void)sixcloseKeyboard
{
    [_inputTextField resignFirstResponder];
}
@end
