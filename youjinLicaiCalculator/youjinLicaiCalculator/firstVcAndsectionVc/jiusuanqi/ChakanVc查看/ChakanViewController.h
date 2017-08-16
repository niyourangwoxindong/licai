//
//  ChakanViewController.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ChakanViewController : BaseViewController
@property (nonatomic ,copy)NSString *benjinString;
@property (nonatomic ,copy)NSString *yuqishouyiString;
@property (nonatomic ,copy)NSString *qishuString;
@property (nonatomic ,copy)NSString *lixiString;
@property (nonatomic ,copy)NSString *nianhuaString;
@property (nonatomic ,copy)NSString *daoqishijianString;
@property (nonatomic ,strong)NSMutableArray *qishuArray;
@property (nonatomic ,strong)NSMutableArray *benjinArray;
@property (nonatomic ,strong)NSMutableArray *lixiArray;
@property (nonatomic ,strong)NSMutableArray *timeendArray;
@end
