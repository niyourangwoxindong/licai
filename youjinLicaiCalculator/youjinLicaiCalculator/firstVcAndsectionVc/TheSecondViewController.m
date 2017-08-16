//
//  TheSecondViewController.m
//  youjinLicaiCalculator
//
//  Created by 柚今科技01 on 2017/6/21.
//  Copyright © 2017年 柚今科技01. All rights reserved.
//

#import "TheSecondViewController.h"
#import "MoreFoundTableViewCell.h"
#import "ShareManager.h"
#import "MoreWebViewController.h"

@interface TheSecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)NSMutableArray *threeArr;
@property (nonatomic ,strong)NSString *appVersion;
@property (nonatomic, strong)NSString *mobid;
@property (nonatomic ,strong)UIView *theFirstView;
@property (nonatomic ,strong)NSMutableArray *imageArr;
@property (nonatomic ,strong)NSMutableArray *labelArr;
@property (nonatomic ,strong)NSMutableArray *urlStringArr;
@end

@implementation TheSecondViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStairViewDidLoadUINavigationBarTintColor];
    self.title = @"更多发现";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _urlStringArr = [[NSMutableArray alloc]initWithObjects:@"https://luna.58.com/m/hz/zufang_new.shtml?-15=20&tag=juhe_common_first_zufang_new.shtml&PGTID=0d200000-0004-f9ab-d217-bdbb02f8212f&ClickID=1",@"https://luna.58.com/m/hz/ershoufang.shtml?-15=20&tag=juhe_common_first_ershoufang.shtml&PGTID=0d200000-0004-f171-69bc-bb5eb29a0e22&ClickID=1",@"https://luna.58.com/m/autotemplate?city=hz&temname=job_common&tag=juhe_common_thirdzhaopin_title&PGTID=0d200000-0004-f15e-97bd-3f62af654954&ClickID=1",@"https://luna.58.com/m/hz/jianzhi.shtml?-15=20&tag=juhe_common_first_jianzhi_common&PGTID=0d200000-0004-ff91-5586-f6a8b6a55e29&ClickID=1",@"https://luna.58.com/m/hz/car_new.shtml?-15=20&tag=juhe_common_first_ershouche&PGTID=0d200000-0004-f6a8-94c4-9b89ef16f509&ClickID=1",@"https://luna.58.com/m/hz/pets.shtml?-15=20&tag=juhe_common_eighthpets_title&PGTID=0d200000-0004-fbb1-efca-f02b8e763a89&ClickID=1",@"https://luna.58.com/m/autotemplate?city=hz&temname=jiazheng_common&tag=juhe_common_fifthjiazheng_title&PGTID=0d200000-0004-f0ab-566d-180c962cd2e5&ClickID=1",@"https://luna.58.com/m/autotemplate?city=hz&temname=sale_common&tag=juhe_common_first_ershou_common&PGTID=0d200000-0004-f015-518b-f1b2f5fe741c&ClickID=1", nil];
    _imageArr = [[NSMutableArray alloc]initWithObjects:@"icon-rent",@"icon_house",@"icon_work",@"icon_parttime",@"icon_car",@"icon_pet",@"icon_housekeeping",@"icon_transaction", nil];
    _labelArr = [[NSMutableArray alloc]initWithObjects:@"租房",@"买房",@"找工作",@"找兼职",@"买车",@"宠物",@"找家政",@"二手交易", nil];
//    _threeArr = [[NSMutableArray alloc]initWithObjects:@"推荐理财计算器给好友",@"给理财计算器评分",@"当前版本号", nil];
    _threeArr = [[NSMutableArray alloc]initWithObjects:@"推荐理财计算器给好友",@"当前版本号", nil];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    _appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    [self theFirstPartView];
    UITableView *onlyTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, BOScreenH-64) style:UITableViewStyleGrouped];
    onlyTableview.delegate = self;
    onlyTableview.dataSource = self;
    onlyTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:onlyTableview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 376*BOScreenH/1334;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _theFirstView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _threeArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"cell";
    MoreFoundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (cell == nil)
    {
        cell = [[MoreFoundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.threeLabel.text = _threeArr[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.row == 1)
    {
        cell.arrowImage.hidden = YES;
        cell.versionNumberLabel.text = _appVersion;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100*BOScreenH/1334;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 1)
//    {
//         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1232500861&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
//    }
    if (indexPath.row == 0)
    {
//        NSMutableDictionary *customParams = [NSMutableDictionary dictionary];

        ShareManager *manager = [ShareManager shareManagerStandardWithDelegate:nil];
        [manager shareInView:self.view text:@"否则你会错过一个“亿”！！！！！" image:[UIImage imageNamed:@"home_icon_licai"] url:@"https://www.youjin360.com/mobile/page/loanManageMoney.html" title:@"快来下载理财计算器" objid:nil];
//        [manager shareInView:self.view text:@"理财计算器" image:[UIImage imageNamed:@"ssdk_oks_classic_wechat"] url:@"https://www.baidu.com" title:@"理财" objid:nil isNeedMobLink:NO path:@"/PlatformDetail" params:nil mobid:self.mobid result:^(NSString *mobid) {
//            self.mobid = mobid;
//        }];
    }
}
- (void)theFirstPartView
{
    _theFirstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BOScreenW, 376*BOScreenH/1334)];
    _theFirstView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 8; i ++)
    {
        int j = i%4;
        int k = i/4;
        UIButton *bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bankButton.frame = CGRectMake(40*BOScreenW/750+j*(78*BOScreenW/750+119*BOScreenW/750), 40*BOScreenH/1334+(78*BOScreenW/750+95*BOScreenH/1334)*k, 78*BOScreenW/750, 78*BOScreenW/750);
        bankButton.tag = i;
        [bankButton setBackgroundImage:[UIImage imageNamed:_imageArr[i]] forState:UIControlStateNormal];
        [bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_theFirstView addSubview:bankButton];
        
        UILabel *bankLabel  = [[UILabel alloc]init];
        bankLabel.frame = CGRectMake(17*BOScreenW/750+j*(120*BOScreenW/750+79*BOScreenW/750), 141*BOScreenH/1334+(108*BOScreenW/750+61*BOScreenH/1334)*k, 120*BOScreenW/750, 13);
        bankLabel.text = _labelArr[i];
        bankLabel.textColor = [UIColor colorWithHexString:@"#757575" alpha:1];
        bankLabel.font = [UIFont systemFontOfSize:12];
        bankLabel.textAlignment = NSTextAlignmentCenter;
        [_theFirstView addSubview:bankLabel];
    }
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 375*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
    lineview.backgroundColor = [UIColor colorWithHexString:@"#dadee3" alpha:1];
    [_theFirstView addSubview:lineview];
}
- (void)bankButtonClick:(UIButton *)sender
{
    MoreWebViewController *webVc = [[MoreWebViewController alloc]init];
    webVc.hidesBottomBarWhenPushed = YES;
    webVc.titleNameString = _labelArr[sender.tag];
    webVc.urlString = _urlStringArr[sender.tag];
    [self.navigationController pushViewController:webVc animated:YES];
}
@end
