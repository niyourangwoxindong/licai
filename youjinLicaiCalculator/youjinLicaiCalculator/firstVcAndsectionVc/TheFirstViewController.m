//
//  TheFirstViewController.m
//  youjinLicaiCalculator
//
//  Created by 柚今科技01 on 2017/6/21.
//  Copyright © 2017年 柚今科技01. All rights reserved.
//

#import "TheFirstViewController.h"
#import "BankFinancingView.h"
#import "PTwoPFinancingView.h"
#import "InterestTableViewController.h"
#import "PickerviewsView.h"
#import "BankFinancialModel.h"
#import "DatePickerView.h"
#import "PtwoPfinancialModel.h"
#import "ChakanViewController.h"
#import "HuankuanlistModel.h"
#import "PingtaiRecommendedModel.h"

@interface TheFirstViewController ()<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)PTwoPFinancingView *ptwopView;//点击P2P理财显示的view
@property (nonatomic ,strong)BankFinancingView *bankfiView;//点击银行理财显示的view
@property (nonatomic ,copy)NSString *jilustring;//记录是在那个按钮进去的
//银行理财
@property (nonatomic ,strong)PickerviewsView *pickerView;
@property (nonatomic ,strong)NSMutableArray *cunkuanArr;//存款期限的pickerView数据
@property (nonatomic ,copy)NSString *cklimitString;//后台需要的存款期限
@property (nonatomic ,copy)NSString *timetypeString;//后台需要的时间类型
//P2P理财
@property (nonatomic ,strong)DatePickerView *datePickerView;
@property (nonatomic ,strong)NSMutableArray *huankuanArr;//还款方式的pickerView数据
@property (nonatomic ,copy)NSString *yueAndriString;//月和日后台需要的请求参数
@property (nonatomic ,copy)NSString *nianAndriString;//年和日后台需要的请求参数
@property (nonatomic ,copy)NSString *yearDayString;//360 365
@property (nonatomic ,copy)NSString *jkfsString;//还款方式后台需要的参数的请求参数
@property (nonatomic ,strong)PtwoPfinancialModel *model;

@property (nonatomic ,copy)NSString *huoqiStr;
@property (nonatomic ,copy)NSString *dingqiStr;
@property (nonatomic ,copy)NSString *lilvshifobian;

//还款明细
@property (nonatomic ,strong)NSMutableArray *qishuArr;
@property (nonatomic ,strong)NSMutableArray *benjinArr;
@property (nonatomic ,strong)NSMutableArray *lixiArr;
@property (nonatomic ,strong)NSMutableArray *timeendArr;

//这个字段用来记录推荐平台是否展开了
@property (nonatomic ,assign)BOOL tujianIszhankai;

@end

@implementation TheFirstViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStairViewDidLoadUINavigationBarTintColor];
    [self imageSetbackgroundAboutNavigationBar];
    
//    self.title = @"理财计算";
    self.navigationItem.title = @"理财计算器";
//    self.tabBarItem.title = @"理财计算";
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;//控制整个功能是否启用
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createRightBarButtonItemWithTitle:@"利率表" withMethod:@selector(rightButtonClick)];
    _tujianIszhankai = YES;
    _qishuArr = [NSMutableArray array];
    _benjinArr = [NSMutableArray array];
    _lixiArr = [NSMutableArray array];
    _timeendArr = [NSMutableArray array];
    _lilvshifobian = @"huoqi";
    _dingqiStr = @"1.50";
    
    _jkfsString = @"2";
    _yearDayString = @"365";
    _nianAndriString = @"y";
    _yueAndriString = @"m";
    _cunkuanArr = [[NSMutableArray alloc]initWithObjects:@"1年",@"2年",@"3年",@"5年",@"3个月",@"6个月", nil];
    _cklimitString = @"1";
    _timetypeString = @"y";
    _huankuanArr = [[NSMutableArray alloc]initWithObjects:@"按月付息到期还本",@"一次性还本付息",@"等额本息", nil];
    
    //点击P2P理财显示的view
    _ptwopView = [[PTwoPFinancingView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _ptwopView.inputsTextField.delegate = self;
    _ptwopView.monthTextField.delegate = self;
    _ptwopView.yearTextField.delegate = self;
    _ptwopView.cashBackTextField.delegate = self;
    _ptwopView.deductionTextField.delegate = self;
    _ptwopView.feeTextField.delegate = self;
    [_ptwopView.lookButton addTarget:self action:@selector(lookButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_ptwopView.timeButton addTarget:self action:@selector(timeButtonClick) forControlEvents:UIControlEventTouchUpInside];//起息日期的按钮
    [_ptwopView.meansButton addTarget:self action:@selector(meansButtonClick) forControlEvents:UIControlEventTouchUpInside];//还款方式的按钮
    [_ptwopView.monthSegmentCon addTarget:self action:@selector(monthSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//添加月 日响应方法
    [_ptwopView.yearSegmentCon addTarget:self action:@selector(yearSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//添加年 日响应方法
    [_ptwopView.dayButton addTarget:self action:@selector(dayButtonClick:) forControlEvents:UIControlEventTouchUpInside];//360天制的按钮
    _ptwopView.tuijianptViewsssss.hidden = YES;//刚进来隐藏掉推荐平台的view
    [self.view addSubview:_ptwopView];
    
    //点击银行理财显示的view
    _bankfiView = [[BankFinancingView alloc]initWithFrame:CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH)];
    _bankfiView.inputTextField.delegate = self;
    [_bankfiView.yearButton addTarget:self action:@selector(yearButtonClick) forControlEvents:UIControlEventTouchUpInside];//存款期限的按钮
    [_bankfiView.periodSegmentCon addTarget:self action:@selector(periodSegmentConSelectItem:) forControlEvents:UIControlEventValueChanged];//添加响应方法
    [_bankfiView.myButton addTarget:self action:@selector(myButtonClick) forControlEvents:UIControlEventTouchUpInside];//我要理财赚收益的点击事件
    [self.view addSubview:_bankfiView];
    
    //银行理财 和 P2P理财的背景View
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 80*BOScreenH/1334)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#2d84f2" alpha:1];
    [self.view addSubview:bgView];
    //银行理财 和 P2P理财
    UISegmentedControl *segmentCon = [[UISegmentedControl alloc] initWithItems:@[@"银行理财", @"P2P理财"]];
    segmentCon.frame = CGRectMake(174*BOScreenW/750, 4*BOScreenH/1334, 402*BOScreenW/750, 58*BOScreenH/1334);
    segmentCon.selectedSegmentIndex = 0;
    segmentCon.tintColor = [UIColor whiteColor];
    [segmentCon addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];//添加响应方法
    [bgView addSubview:segmentCon];
    
    //pickerview
    _pickerView = [[PickerviewsView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [_pickerView.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];//取消按钮的点击事件
    [_pickerView.sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];//确定按钮的点击事件
    [[UIApplication sharedApplication].keyWindow addSubview:_pickerView];
    _pickerView.hidden = YES;
    //添加手势单击事件
    UITapGestureRecognizer *Gess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GesClicks:)];
    Gess.delegate = self;
    Gess.numberOfTapsRequired = 1;
    [_pickerView addGestureRecognizer:Gess];
    
    //DatePickerView
    _datePickerView = [[DatePickerView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH)];
    [[UIApplication sharedApplication].keyWindow addSubview:_datePickerView];
    [_datePickerView.sureButtons addTarget:self action:@selector(sureButtonsClick) forControlEvents:UIControlEventTouchUpInside];//确定按钮的点击事件
    [_datePickerView.cancelButtons addTarget:self action:@selector(cancelButtonsClick) forControlEvents:UIControlEventTouchUpInside];
    _datePickerView.hidden = YES;
    //添加手势单击事件
    UITapGestureRecognizer *pkGess = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pkGesClicks:)];
    pkGess.delegate = self;
    pkGess.numberOfTapsRequired = 1;
    [_datePickerView addGestureRecognizer:pkGess];
    
    [self theInputTatetuijianpingtai];//利率推荐平台接口
}
#pragma mark --- 我要理财赚收益的点击事件---
- (void)myButtonClick
{
    NSString  *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d",1232500861];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
#pragma mark---银行理财 和 P2P理财的点击事件
- (void)selectItem:(UISegmentedControl *)sender
{
    [self.view endEditing:YES];
    if (sender.selectedSegmentIndex == 0)
    {
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
        _ptwopView.hidden = YES;
        _bankfiView.hidden = NO;
    } else
    {
        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
        _bankfiView.hidden = YES;
        _ptwopView.hidden = NO;
    }
}
#pragma mark---银行理财页面的点击事件---
//存款期限的点击事件
- (void)yearButtonClick
{
    [_bankfiView.inputTextField resignFirstResponder];
    _jilustring = @"1111";
    _pickerView.hidden = NO;
    _pickerView.titleLabel.text = @"存款期限";
    _pickerView.number = _cunkuanArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
#pragma mark  取消确定按钮点击事件
- (void)cancelButtonClick
{
    _pickerView.hidden = YES;
}
- (void)sureButtonClick
{
    if ([_jilustring  isEqual: @"1111"])
    {
        if (_pickerView.chooseString == nil)
        {
            _bankfiView.yearLabel.text = @"1年";
            if ([_lilvshifobian isEqualToString:@"huoqi"])
            {
                _bankfiView.zeroLabel.text = @"0.35";
            }else
            {
                _bankfiView.zeroLabel.text = @"1.50";
            }
            
            _dingqiStr = @"1.50";
            
            _cklimitString = @"1";
            _timetypeString = @"y";
        }else
        {
            _bankfiView.yearLabel.text = _pickerView.chooseString;
            if ([_pickerView.chooseString isEqual:@"1年"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"1.50";
                }
                
                _dingqiStr = @"1.50";
                
                _cklimitString = @"1";
                _timetypeString = @"y";
            }
            if ([_pickerView.chooseString isEqual:@"2年"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"2.10";
                }
                _dingqiStr = @"2.10";
                
                _cklimitString = @"2";
                _timetypeString = @"y";
            }
            if ([_pickerView.chooseString isEqual:@"3年"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"2.75";
                }
                _dingqiStr = @"2.75";
                
                _cklimitString = @"3";
                _timetypeString = @"y";
            }
            if ([_pickerView.chooseString isEqual:@"5年"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"2.75";
                }
                _dingqiStr = @"2.75";
                
                _cklimitString = @"5";
                _timetypeString = @"y";
            }
            if ([_pickerView.chooseString isEqual:@"3个月"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"1.10";
                }
                
                _dingqiStr = @"1.10";
                
                _cklimitString = @"3";
                _timetypeString = @"m";
            }
            if ([_pickerView.chooseString isEqual:@"6个月"])
            {
                if ([_lilvshifobian isEqualToString:@"huoqi"])
                {
                    _bankfiView.zeroLabel.text = @"0.35";
                }else
                {
                    _bankfiView.zeroLabel.text = @"1.30";
                }
                _dingqiStr = @"1.30";
                
                _cklimitString = @"6";
                _timetypeString = @"m";
            }
        }
    }
    if ([_jilustring  isEqual: @"2222"])
    {
        if (_pickerView.chooseString == nil)
        {
            _ptwopView.chooseLabel.text = @"按月付息到期还本";
            _jkfsString = @"2";
        }else
        {
            _ptwopView.chooseLabel.text = _pickerView.chooseString;
            if ([_pickerView.chooseString isEqual:@"一次性还本付息"])
            {
                _jkfsString = @"1";
            }
            if ([_pickerView.chooseString isEqual:@"按月付息到期还本"])
            {
                _jkfsString = @"2";
            }
            if ([_pickerView.chooseString isEqual:@"等额本息"])
            {
                _jkfsString = @"3";
            }
        }
    }
    _pickerView.chooseString = nil;
    _pickerView.hidden = YES;
    
    //银行的接口
    [self textFieldtextisemptybank];
    //p2p的接口
    [self textFieldtextisempty];
}
#pragma mark---银行理财数据接口----
- (void)bankFinancingData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"money"] = _bankfiView.inputTextField.text;
    parameters[@"time"] = _cklimitString;
    parameters[@"time_type"] = _timetypeString;
    parameters[@"apr"] = _bankfiView.zeroLabel.text;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiBank",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            BankFinancialModel *model = [BankFinancialModel mj_objectWithKeyValues:responseObject[@"data"]];
            _bankfiView.theAmountLabel.text = model.lixi;
            _bankfiView.theAmountOfLabel.text = model.benxi;
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
#pragma mark---P2P理财接口数据---
- (void)ptwopData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"money"] = _ptwopView.inputsTextField.text;
    parameters[@"begin"] = _ptwopView.yearsLabel.text;
    parameters[@"time"] = _ptwopView.monthTextField.text;
    parameters[@"time_type"] = _yueAndriString;
    parameters[@"apr"] = _ptwopView.yearTextField.text;
    parameters[@"apr_type"] = _nianAndriString;
    parameters[@"year_days"] = _yearDayString;
    parameters[@"huankuan_type"] = _jkfsString;
    parameters[@"fanxian"] = _ptwopView.cashBackTextField.text;
    parameters[@"dikou"] = _ptwopView.deductionTextField.text;
    parameters[@"guanli_fee"] = _ptwopView.feeTextField.text;
    [manager POST:[NSString stringWithFormat:@"%@Common/jisuanqiWd",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            _model = [PtwoPfinancialModel mj_objectWithKeyValues:responseObject[@"data"]];
            _ptwopView.rateLabel.text = _model.shiji_apr;
            _ptwopView.expectedLabel.text = _model.yuqi;
            
            [_qishuArr removeAllObjects];
            [_benjinArr removeAllObjects];
            [_lixiArr removeAllObjects];
            [_timeendArr removeAllObjects];
            for (HuankuanlistModel *listmodel in _model.huankuan_list)
            {
                [_qishuArr addObject:listmodel.qishu];
                [_benjinArr addObject:listmodel.benjin];
                [_lixiArr addObject:listmodel.lixi];
                [_timeendArr addObject:listmodel.time_end];
            }
        }
        else
        {
            NSLog(@"返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}


#pragma mark---p2p理财页面的处理---
//起息日期
- (void)timeButtonClick
{
    [self.view endEditing:YES];
    _datePickerView.hidden = NO;
}
//创建一个PickerView日期格式器 (确定 按钮的点击事件)
- (void)sureButtonsClick
{
    NSDate *selected = [_datePickerView.datePickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    _ptwopView.yearsLabel.text = destDateString;
    _datePickerView.hidden = YES;
}
//取消按钮的点击事件
- (void)cancelButtonsClick
{
    _datePickerView.hidden = YES;
}
//还款方式的点击事件
- (void)meansButtonClick
{
    [self.view endEditing:YES];
    _jilustring = @"2222";
    _pickerView.hidden = NO;
    _pickerView.titleLabel.text = @"还款方式";
    _pickerView.number = _huankuanArr;
    [_pickerView.payPicView selectRow:0 inComponent:0 animated:NO];
    [_pickerView.payPicView reloadAllComponents];
}
#pragma mark---单击手势的代理---
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:_pickerView.buttonView] || [touch.view isDescendantOfView:_pickerView.payPicView] || [touch.view isDescendantOfView:_datePickerView.buttonViews] ||[touch.view isDescendantOfView:_datePickerView.datePickerView])
    {
        return NO;
    }
    return YES;
}

- (void)GesClicks:(UITapGestureRecognizer *)sender
{
    _pickerView.hidden = YES;
}
- (void)pkGesClicks:(UITapGestureRecognizer *)sender
{
    _datePickerView.hidden = YES;
}
#pragma mark---利率表的点击事件---
- (void)rightButtonClick
{
    InterestTableViewController *interVc = [[InterestTableViewController alloc]init];
    // 每当push操作的时候，隐藏掉底部的TabBar
    interVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:interVc animated:YES];
}
#pragma mark ---pop返回前一页---
- (void)leftBarButtonItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//月和日segmen的点击事件
- (void)monthSegmentConSelectItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _yueAndriString = @"m";
    } else
    {
        _yueAndriString = @"d";
    }
    [self textFieldtextisempty];
}
//年和日segmen的点击事件
- (void)yearSegmentConSelectItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _nianAndriString = @"y";
    } else
    {
        _nianAndriString = @"d";
    }
    [self textFieldtextisempty];
}
//360天制的点击按钮事件
- (void)dayButtonClick:(UIButton *)sender
{
    if (sender.selected)
    {
        _yearDayString = @"365";
        [_ptwopView.dayButton setImage:[UIImage imageNamed:@"icon_select_nor"] forState:UIControlStateNormal];
        sender.selected = NO;
    }else
    {
        _yearDayString = @"360";
        [_ptwopView.dayButton setImage:[UIImage imageNamed:@"icon_select_pre"] forState:UIControlStateNormal];
        sender.selected = YES;
    }
    [self textFieldtextisempty];
}

#pragma mark ---银行理财------------------------
//活期定期的点击事件
- (void)periodSegmentConSelectItem:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _lilvshifobian = @"huoqi";
        _bankfiView.zeroLabel.text = @"0.35";
    } else
    {
        _lilvshifobian = @"dingqi";
        _bankfiView.zeroLabel.text = _dingqiStr;
    }
    [self textFieldtextisemptybank];
}
#pragma mark---输入框 键盘开始响应 和 结束响应时的代理-----
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _ptwopView.monthTextField)
    {
        if (iPhone5)
        {
            [UIView animateWithDuration:0.30f animations:^{
                _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 50*BOScreenH/1334, BOScreenW, BOScreenH);
            }];
        }
    }
    
    if (textField == _ptwopView.yearTextField)
    {
        [UIView animateWithDuration:0.30f animations:^{
            _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 30*BOScreenH/1334, BOScreenW, BOScreenH);
            if (iPhone6P)
            {
                _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH);
            }
            if (iPhone5)
            {
                _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 150*BOScreenH/1334, BOScreenW, BOScreenH);
            }
        }];
    }
    if (textField == _ptwopView.cashBackTextField || textField == _ptwopView.deductionTextField)
    {
        if (_tujianIszhankai == YES)
        {
            [UIView animateWithDuration:0.30f animations:^{
                _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 230*BOScreenH/1334, BOScreenW, BOScreenH);
                if (iPhone6P)
                {
                    _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 200*BOScreenH/1334, BOScreenW, BOScreenH);
                }
                if (iPhone5)
                {
                    _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 350*BOScreenH/1334, BOScreenW, BOScreenH);
                }
            }];
        }else
        {
            [UIView animateWithDuration:0.30f animations:^{
                _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 270*BOScreenH/1334, BOScreenW, BOScreenH);
                if (iPhone6P)
                {
                    _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 240*BOScreenH/1334, BOScreenW, BOScreenH);
                }
                if (iPhone5)
                {
                    _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 390*BOScreenH/1334, BOScreenW, BOScreenH);
                }
            }];
        }
    }
    if (textField == _ptwopView.feeTextField)
    {
        if (_tujianIszhankai == YES)
        {
            [UIView animateWithDuration:0.30f animations:^{
                _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 330*BOScreenH/1334, BOScreenW, BOScreenH);
                if (iPhone6P)
                {
                    _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 300*BOScreenH/1334, BOScreenW, BOScreenH);
                }
                if (iPhone5)
                {
                    _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 450*BOScreenH/1334, BOScreenW, BOScreenH);
                }
            }];
        }else
        {
            [UIView animateWithDuration:0.30f animations:^{
                _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 370*BOScreenH/1334, BOScreenW, BOScreenH);
                if (iPhone6P)
                {
                    _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 340*BOScreenH/1334, BOScreenW, BOScreenH);
                }
                if (iPhone5)
                {
                    _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334 - 490*BOScreenH/1334, BOScreenW, BOScreenH);
                }
            }];
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _bankfiView.inputTextField)
    {
        [self textFieldtextisemptybank];
    }else
    {
        [self textFieldtextisempty];
    }
    
    //利率输入推荐平台的接口
    if (textField == _ptwopView.yearTextField)
    {
        if (_ptwopView.yearTextField.text.length > 0)
        {
            if (tokenString)
            {
                [self theInputTatetuijianpingtai];
            }else
            {
                //得到token
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                parameters[@"app_id"] = @"2";
                parameters[@"secret"] = @"2e1eec48cae70a2c3bd8b1f2f2e177ea";
                [manager POST:[NSString stringWithFormat:@"%@Auth/accessToken",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"at"] forKey:@"access_token"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     
                     [self theInputTatetuijianpingtai];
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     NSLog(@"token请求失败没有网络%@",error);
                 }];
            }
        }else
        {
            _ptwopView.tuijianptViewsssss.hidden = YES;//推荐平台的view
            
            UIView *bgView = (UIView *)[self.view viewWithTag:1000];
            bgView.frame = CGRectMake(0, 248*BOScreenH/1334, BOScreenW, 700*BOScreenH/1334);
            // 位置的调整
            UILabel *onelabel = (UILabel *)[self.view viewWithTag:20];
            onelabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 0*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334);
            UILabel *twolabel = (UILabel *)[self.view viewWithTag:21];
            twolabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 1*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334);
            UILabel *threelabel = (UILabel *)[self.view viewWithTag:22];
            threelabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 2*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334);
            UIView *oneView = (UIView *)[self.view viewWithTag:30];
            oneView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 0*100*BOScreenH/1334 , 720*BOScreenW/750, 1*BOScreenH/1334);
            UIView *twoView = (UIView *)[self.view viewWithTag:31];
            twoView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 1*100*BOScreenH/1334 , 720*BOScreenW/750, 1*BOScreenH/1334);
            UIView *threeView = (UIView *)[self.view viewWithTag:32];
            threeView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 2*100*BOScreenH/1334 , 720*BOScreenW/750, 1*BOScreenH/1334);
            UIImageView *oneImage = (UIImageView *)[self.view viewWithTag:1001];
            oneImage.frame = CGRectMake(705*BOScreenW/750, 435*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334);
            _ptwopView.chooseLabel.frame = CGRectMake(380*BOScreenW/750, 435*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334);
            _ptwopView.meansButton.frame = CGRectMake(0, 400*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
            _ptwopView.cashBackTextField.frame = CGRectMake(160*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
            if (iPhone5)
            {
                   _ptwopView.cashBackTextField.frame = CGRectMake(180*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
            }
            _ptwopView.deductionTextField.frame = CGRectMake(540*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
            UILabel *bblabel = (UILabel *)[self.view viewWithTag:1003];
            bblabel.frame = CGRectMake(370*BOScreenW/750, 521*BOScreenH/1334, 150*BOScreenW/750, 58*BOScreenH/1334);
            _ptwopView.feeTextField.frame = CGRectMake(400*BOScreenW/750, 635*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334);
//            _ptwopView.myNeedButton.frame = CGRectMake(135*BOScreenW/750, 978*BOScreenH/1334, 480*BOScreenW/750, 80*BOScreenH/1334);
            
            _tujianIszhankai = YES;
        }
    }
    
    [UIView animateWithDuration:0.30f animations:^{
        _ptwopView.frame = CGRectMake(0, 80*BOScreenH/1334, BOScreenW, BOScreenH);
    }];
}

#pragma mark ---p2p理财----------------------------
//判断是否为空输入框
- (void)textFieldtextisempty
{
    if (_ptwopView.inputsTextField.text.length>0&&_ptwopView.monthTextField.text.length>0&&_ptwopView.yearTextField.text.length>0)
    {
        unichar onesingle = [_ptwopView.inputsTextField.text characterAtIndex:0];//当前输入的字符
        unichar twosingle = [_ptwopView.monthTextField.text characterAtIndex:0];//当前输入的字符
        unichar threesingle = [_ptwopView.yearTextField.text characterAtIndex:0];//当前输入的字符
        if (onesingle == '.' || twosingle == '.'|| threesingle == '.')
        {
            NSLog(@"第一个字符不能为点");
        }else
        {
            if (tokenString)
            {
                [self ptwopData];
            }else
            {
                //得到token
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                parameters[@"app_id"] = @"2";
                parameters[@"secret"] = @"2e1eec48cae70a2c3bd8b1f2f2e177ea";
                [manager POST:[NSString stringWithFormat:@"%@Auth/accessToken",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"at"] forKey:@"access_token"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     
                     [self ptwopData];
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     NSLog(@"token请求失败没有网络%@",error);
                 }];
            }
        }
    }else
    {
        NSLog(@"不能为空");
        _ptwopView.rateLabel.text = @"0";
        _ptwopView.expectedLabel.text = @"0";
    }
}
#pragma mark------银行理财-------
//判断输入框是否为空
- (void)textFieldtextisemptybank
{
    if (_bankfiView.inputTextField.text.length>0)
    {
        unichar single = [_bankfiView.inputTextField.text characterAtIndex:0];//当前输入的字符
        if (single == '.')
        {
            NSLog(@"第一个字符不能为点");
        }else
        {
            if (tokenString)
            {
                [self bankFinancingData];
            }else
            {
                //得到token
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                parameters[@"app_id"] = @"2";
                parameters[@"secret"] = @"2e1eec48cae70a2c3bd8b1f2f2e177ea";
                [manager POST:[NSString stringWithFormat:@"%@Auth/accessToken",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"at"] forKey:@"access_token"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     
                     [self bankFinancingData];
                     
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     NSLog(@"token请求失败没有网络%@",error);
                 }];
            }
        }
    }else
    {
        NSLog(@"请输入金额");
        _bankfiView.theAmountLabel.text = @"0";
        _bankfiView.theAmountOfLabel.text = @"0";
    }
}
#pragma mark查看按钮的点击事件----------------
- (void)lookButtonClick
{
    if (_model.huankuan_list.count > 0)
    {
        if (_ptwopView.inputsTextField.text.length>0&&_ptwopView.monthTextField.text.length>0&&_ptwopView.yearTextField.text.length>0)
        {
            ChakanViewController *chakanvc = [[ChakanViewController alloc]init];
            chakanvc.benjinString = _model.money;
            chakanvc.yuqishouyiString = _model.yuqi;
            chakanvc.qishuString = [NSString stringWithFormat:@"%lu",(unsigned long)_model.huankuan_list.count];
            chakanvc.lixiString = _model.lixi;
            chakanvc.nianhuaString = _model.shiji_apr;
            chakanvc.daoqishijianString = _model.time_end;
            chakanvc.qishuArray =_qishuArr;
            chakanvc.benjinArray = _benjinArr;
            chakanvc.lixiArray = _lixiArr;
            chakanvc.timeendArray = _timeendArr;
            // 每当push操作的时候，隐藏掉底部的TabBar
            chakanvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chakanvc animated:YES];
        }
    }
}

#pragma mark---p2p输入利率时的平台推荐的接口----
- (void)theInputTatetuijianpingtai
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"at"] = tokenString;
    parameters[@"apr"] = _ptwopView.yearTextField.text;
    [manager POST:[NSString stringWithFormat:@"%@Common/getTuijianByApr",BASEURL] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"r"] integerValue] == 1)
        {
            PingtaiRecommendedModel *model = [PingtaiRecommendedModel mj_objectWithKeyValues:responseObject[@"data"]];
            NSLog(@"ptmc%@",model.pname);
            if (model.pname.length > 0)
            {
                _ptwopView.tuijianptViewsssss.hidden = NO;//推荐平台的view
                _ptwopView.tuijianptLable.text = [NSString stringWithFormat:@"%@%@利率的平台：%@",_ptwopView.yearTextField.text,@"%",model.pname];
                NSString *bianStr = [NSString stringWithFormat:@"%@%@",_ptwopView.yearTextField.text,@"%"];
                NSString *bubianStr = [NSString stringWithFormat:@"利率的平台：%@",model.pname];
                [self label:_ptwopView.tuijianptLable bubian:bianStr bian:bubianStr];
                
                // 位置的调整
                
                UIView *bgView = (UIView *)[self.view viewWithTag:1000];
                bgView.frame = CGRectMake(0, 248*BOScreenH/1334, BOScreenW, 740*BOScreenH/1334);
                
                UILabel *onelabel = (UILabel *)[self.view viewWithTag:20];
                onelabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 0*(30*BOScreenH/1334+70*BOScreenH/1334) + 40*BOScreenH/1334, 230*BOScreenW/750, 30*BOScreenH/1334);
                UILabel *twolabel = (UILabel *)[self.view viewWithTag:21];
                twolabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 1*(30*BOScreenH/1334+70*BOScreenH/1334) + 40*BOScreenH/1334, 230*BOScreenW/750, 30*BOScreenH/1334);
                UILabel *threelabel = (UILabel *)[self.view viewWithTag:22];
                threelabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 2*(30*BOScreenH/1334+70*BOScreenH/1334) + 40*BOScreenH/1334, 230*BOScreenW/750, 30*BOScreenH/1334);
                UIView *oneView = (UIView *)[self.view viewWithTag:30];
                oneView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 0*100*BOScreenH/1334 +40*BOScreenH/1334, 720*BOScreenW/750, 1*BOScreenH/1334);
                UIView *twoView = (UIView *)[self.view viewWithTag:31];
                twoView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 1*100*BOScreenH/1334 +40*BOScreenH/1334, 720*BOScreenW/750, 1*BOScreenH/1334);
                UIView *threeView = (UIView *)[self.view viewWithTag:32];
                threeView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 2*100*BOScreenH/1334 +40*BOScreenH/1334, 720*BOScreenW/750, 1*BOScreenH/1334);
                UIImageView *oneImage = (UIImageView *)[self.view viewWithTag:1001];
                oneImage.frame = CGRectMake(705*BOScreenW/750, 435*BOScreenH/1334+40*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334);
                _ptwopView.chooseLabel.frame = CGRectMake(380*BOScreenW/750, 435*BOScreenH/1334+40*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334);
                _ptwopView.meansButton.frame = CGRectMake(0, 400*BOScreenH/1334+40*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
                _ptwopView.cashBackTextField.frame = CGRectMake(160*BOScreenW/750, 521*BOScreenH/1334+40*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
                if (iPhone5)
                {
                    _ptwopView.cashBackTextField.frame = CGRectMake(180*BOScreenW/750, 521*BOScreenH/1334+40*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
                }
                _ptwopView.deductionTextField.frame = CGRectMake(540*BOScreenW/750, 521*BOScreenH/1334+40*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
                UILabel *bblabel = (UILabel *)[self.view viewWithTag:1003];
                bblabel.frame = CGRectMake(370*BOScreenW/750, 521*BOScreenH/1334+40*BOScreenH/1334, 150*BOScreenW/750, 58*BOScreenH/1334);
                _ptwopView.feeTextField.frame = CGRectMake(400*BOScreenW/750, 635*BOScreenH/1334+40*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334);
//                _ptwopView.myNeedButton.frame = CGRectMake(135*BOScreenW/750, 978*BOScreenH/1334+40*BOScreenH/1334, 480*BOScreenW/750, 80*BOScreenH/1334);
                
                _tujianIszhankai = NO;
            }else
            {
                _ptwopView.tuijianptViewsssss.hidden = YES;//推荐平台的view
                
                UIView *bgView = (UIView *)[self.view viewWithTag:1000];
                bgView.frame = CGRectMake(0, 248*BOScreenH/1334, BOScreenW, 700*BOScreenH/1334);
                // 位置的调整
                UILabel *onelabel = (UILabel *)[self.view viewWithTag:20];
                onelabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 0*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334);
                UILabel *twolabel = (UILabel *)[self.view viewWithTag:21];
                twolabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 1*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334);
                UILabel *threelabel = (UILabel *)[self.view viewWithTag:22];
                threelabel.frame = CGRectMake(30*BOScreenW/750, 435*BOScreenH/1334 + 2*(30*BOScreenH/1334+70*BOScreenH/1334), 230*BOScreenW/750, 30*BOScreenH/1334);
                UIView *oneView = (UIView *)[self.view viewWithTag:30];
                oneView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 0*100*BOScreenH/1334 , 720*BOScreenW/750, 1*BOScreenH/1334);
                UIView *twoView = (UIView *)[self.view viewWithTag:31];
                twoView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 1*100*BOScreenH/1334 , 720*BOScreenW/750, 1*BOScreenH/1334);
                UIView *threeView = (UIView *)[self.view viewWithTag:32];
                threeView.frame = CGRectMake(30*BOScreenW/750, 400*BOScreenH/1334 + 2*100*BOScreenH/1334 , 720*BOScreenW/750, 1*BOScreenH/1334);
                UIImageView *oneImage = (UIImageView *)[self.view viewWithTag:1001];
                oneImage.frame = CGRectMake(705*BOScreenW/750, 435*BOScreenH/1334, 15*BOScreenW/750, 30*BOScreenH/1334);
                _ptwopView.chooseLabel.frame = CGRectMake(380*BOScreenW/750, 435*BOScreenH/1334, 315*BOScreenW/750, 30*BOScreenH/1334);
                _ptwopView.meansButton.frame = CGRectMake(0, 400*BOScreenH/1334, BOScreenW, 100*BOScreenH/1334);
                _ptwopView.cashBackTextField.frame = CGRectMake(160*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
                if (iPhone5)
                {
                      _ptwopView.cashBackTextField.frame = CGRectMake(180*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
                }
                _ptwopView.deductionTextField.frame = CGRectMake(540*BOScreenW/750, 521*BOScreenH/1334, 180*BOScreenW/750, 58*BOScreenH/1334);
                UILabel *bblabel = (UILabel *)[self.view viewWithTag:1003];
                bblabel.frame = CGRectMake(370*BOScreenW/750, 521*BOScreenH/1334, 150*BOScreenW/750, 58*BOScreenH/1334);
                _ptwopView.feeTextField.frame = CGRectMake(400*BOScreenW/750, 635*BOScreenH/1334, 320*BOScreenW/750, 30*BOScreenH/1334);
//                _ptwopView.myNeedButton.frame = CGRectMake(135*BOScreenW/750, 978*BOScreenH/1334, 480*BOScreenW/750, 80*BOScreenH/1334);
                
                _tujianIszhankai = YES;
            }
        }
        else
        {
            NSLog(@"请求没有成功返回信息描述%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//字体显示两种颜色
- (void)label:(UILabel *)label bubian:(NSString *)str bian:(NSString *)string
{
    NSMutableAttributedString *twonoteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",str,string]];
    NSRange tworedRangeTwo = NSMakeRange([[twonoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",string]].location, [[twonoteStr string] rangeOfString:[NSString stringWithFormat:@"%@",string]].length);
    [twonoteStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#b87b5a" alpha:1] range:tworedRangeTwo];
    [label setAttributedText:twonoteStr];
    //    [label sizeToFit];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
