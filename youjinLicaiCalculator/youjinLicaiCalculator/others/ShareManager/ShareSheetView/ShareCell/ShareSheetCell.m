//
//  ShareSheetCell.m
//  renyan
//
//  Created by 杭州自心科技 on 16/7/5.
//  Copyright © 2016年 zixin. All rights reserved.
//

#import "ShareSheetCell.h"

@implementation ShareSheetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}

- (void)configureViews {
    [self layoutConstraintConfigure];
    self.containerView.clipsToBounds = NO;
}

- (void)layoutConstraintConfigure {
    self.containerTopToSuperTop.constant = 20 * DEFAULT_SCREEN_RATIO;
    self.containerViewLeftToSuperLeft.constant = 10 * DEFAULT_SCREEN_RATIO;
}

- (void)updateCellWithPlatform:(SSDKPlatform *)plateform {
    self.plateform = plateform;
    self.shareIconImageView.image = plateform.icon;
    self.shareLable.text = plateform.name;
}


@end
