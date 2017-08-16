//
//  DatePickerView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

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
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.35];

        //确定 取消 按钮
        _buttonViews = [[UIView alloc]initWithFrame:CGRectMake(0, BOScreenH-520*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334)];
        _buttonViews.backgroundColor = [UIColor colorWithRed:246.0/255 green:247.0/255 blue:248.0/255 alpha:1];
        [self addSubview:_buttonViews];
        //取消按钮
        _cancelButtons = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButtons.frame = CGRectMake(0, 25*BOScreenH/1334, 100*BOScreenW/750, 40*BOScreenH/1334);
        [_cancelButtons setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButtons setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
        _cancelButtons.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonViews addSubview:_cancelButtons];
        //中间标题
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(200*BOScreenW/750, 25*BOScreenH/1334, 350*BOScreenW/750, 40*BOScreenH/1334)];
        _titleLabel.text = @"起息日期";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_buttonViews addSubview:_titleLabel];
        //确定按钮
        _sureButtons = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButtons.frame = CGRectMake(650*BOScreenW/750, 25*BOScreenH/1334, 100*BOScreenW/750, 40*BOScreenH/1334);
        [_sureButtons setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButtons setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
        _sureButtons.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonViews addSubview:_sureButtons];
        
        //UIDatePicker
        _datePickerView =  [[UIDatePicker alloc]init];
        _datePickerView.frame = CGRectMake(0, BOScreenH - 430*BOScreenH/1334, BOScreenW, 430*BOScreenH/1334);
        _datePickerView.backgroundColor = [UIColor whiteColor];
        _datePickerView.datePickerMode = UIDatePickerModeDate;
       //根据当前日历时间设置 dateComponents 偏移值差，得到最大时间
        NSCalendar *calendar = [NSCalendar currentCalendar];
        //设置偏差
        NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
        [dateComponents setYear:100];
        [dateComponents setMonth:0];
        [dateComponents setDay:0];
        NSDate *maxDate = [calendar dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
//        _datePickerView.minimumDate = [NSDate date];最小当前事件
//        _datePickerView.minimumDate = nil;不限最小事件
        NSDate *currentDate = [NSDate date];
        [dateComponents setYear:-10];//设置最小时间为：当前时间前推十年
        NSDate *minDate = [calendar dateByAddingComponents:dateComponents toDate:currentDate options:0];
        _datePickerView.minimumDate = minDate;
        _datePickerView.maximumDate = maxDate;
        [self addSubview:_datePickerView];
    }
    return self;
}
@end
