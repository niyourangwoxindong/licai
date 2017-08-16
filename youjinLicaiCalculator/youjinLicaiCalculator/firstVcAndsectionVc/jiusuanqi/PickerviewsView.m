//
//  PickerviewsView.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "PickerviewsView.h"

@interface PickerviewsView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@end

@implementation PickerviewsView

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
        self.number = [NSMutableArray array];
        NSLog(@"self.number%@",self.number);
        //确定 取消 按钮
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, BOScreenH-520*BOScreenH/1334, BOScreenW, 90*BOScreenH/1334)];
        _buttonView.backgroundColor = [UIColor colorWithRed:246.0/255 green:247.0/255 blue:248.0/255 alpha:1];
        [self addSubview:_buttonView];
        //取消按钮
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, 25*BOScreenH/1334, 100*BOScreenW/750, 40*BOScreenH/1334);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonView addSubview:_cancelButton];
        //中间标题
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(200*BOScreenW/750, 25*BOScreenH/1334, 350*BOScreenW/750, 40*BOScreenH/1334)];
//        _titleLabel.text = @"起息日起起息日起";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_buttonView addSubview:_titleLabel];
        //确定按钮
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(650*BOScreenW/750, 25*BOScreenH/1334, 100*BOScreenW/750, 40*BOScreenH/1334);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor colorWithHexString:@"#2d84f2" alpha:1] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_buttonView addSubview:_sureButton];
        
        //UIPickerView
        _payPicView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, BOScreenH - 430*BOScreenH/1334, BOScreenW, 430*BOScreenH/1334)];
        _payPicView.delegate = self;
        _payPicView.dataSource = self;
        _payPicView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_payPicView];
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.number.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component)
    {
        case 0:
            title = self.number[row];
            break;
        default:
            break;
    }
    
    return title;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 70*BOScreenH/1334;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithHexString:@"#dfe3e6" alpha:1];
        }
    }
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = self.number[row];
    genderLabel.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    genderLabel.font = [UIFont systemFontOfSize:21];
    
    return genderLabel;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    NSString  *genderStr = [NSString stringWithFormat:@"%@",self.number[row]];//获取选中的文字，以便于在别的地方使用
    _chooseString = genderStr;
    NSLog(@"genderStr%@",genderStr);
}

@end
