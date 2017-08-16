//
//  NSDate+Date.h
//  BuDeJie19
//
//  Created by xmg5 on 16/10/26.
//  Copyright © 2016年 Seemygo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Date)

- (BOOL)isThisYear;

- (BOOL)isThisToday;

- (BOOL)isThisYesterday;

- (NSDateComponents *)detalWithNow;

@end
