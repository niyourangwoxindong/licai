//
//  DatePickerView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/16.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView
@property (nonatomic ,strong)UIView *buttonViews;//确定 取消 按钮
@property (nonatomic ,strong)UIButton *cancelButtons;//取消按钮
@property (nonatomic ,strong)UILabel *titleLabel;//中间标题
@property (nonatomic ,strong)UIButton *sureButtons;//确定按钮
@property (nonatomic ,strong)UIDatePicker *datePickerView;
@end
