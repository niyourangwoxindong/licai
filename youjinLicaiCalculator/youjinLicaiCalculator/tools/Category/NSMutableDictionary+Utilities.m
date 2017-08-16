//
//  NSMutableDictionary+Utilities.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/3.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "NSMutableDictionary+Utilities.h"

@implementation NSMutableDictionary (Utilities)

- (void)setNewObject:(id)object forKey:(id<NSCopying>)akey {
    if (!object || !akey) {
        return;
    }
    [self setObject:object forKey:akey];
}

@end
