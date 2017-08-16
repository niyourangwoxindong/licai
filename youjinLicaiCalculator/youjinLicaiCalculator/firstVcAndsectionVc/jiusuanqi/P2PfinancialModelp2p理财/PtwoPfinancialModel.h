//
//  PtwoPfinancialModel.h
//  YouJin
//
//  Created by 柚今科技01 on 2017/5/22.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PtwoPfinancialModel : NSObject
@property (nonatomic ,copy)NSString *lixi;//利息
@property (nonatomic ,copy)NSString *money;//投资金额
@property (nonatomic ,copy)NSString *yuqi;//预期收益
@property (nonatomic ,copy)NSString *shiji_apr;//实际年化
@property (nonatomic ,copy)NSString *time_end;//到期时间
@property (nonatomic ,strong)NSMutableArray *huankuan_list;//还款明细
@end
