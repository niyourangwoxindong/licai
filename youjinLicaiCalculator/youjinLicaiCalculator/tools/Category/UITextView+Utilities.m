//
//  UITextView+Utilities.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/6/8.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "UITextView+Utilities.h"
//#import "NSString+Utilities.h"

@implementation UITextView (Utilities)


- (NSInteger)caculateTextViewTextCount
{
    NSString *toBeString = self.text;
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    static NSInteger wordLength = 0;
    if (!position) {
        NSInteger allDataLength = toBeString.length;
        wordLength = allDataLength;
    }
    return (int)floor(wordLength);
}

@end
