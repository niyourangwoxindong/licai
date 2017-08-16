//
//  PickerviewsView.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/11.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerviewsView : UIView
@property (nonatomic ,strong)UIView *buttonView;//确定 取消 按钮
@property (nonatomic ,strong)UIButton *cancelButton;//取消按钮
@property (nonatomic ,strong)UILabel *titleLabel;//中间标题
@property (nonatomic ,strong)UIButton *sureButton;//确定按钮
@property (nonatomic ,strong)UIPickerView *payPicView;
@property (nonatomic,strong)NSMutableArray * number;//保存要展示的数字
@property (nonatomic ,strong)NSString *chooseString;//选中的数字
@end
