//
//  NSMutableDictionary+Utilities.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Utilities)

- (void)setNewObject:(id)object forKey:(id<NSCopying>)akey;

@end
