//
//  ShareSheetCell.h
//  renyan
//
//  Created by 杭州自心科技 on 16/7/5.
//  Copyright © 2016年 zixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/SSDKPlatform.h>

#define kshareSheetCellIdentifier @"shareSheetCell"
#define DEFAULT_SCREEN_RATIO ([UIScreen screenWidth] / 375.0)

@interface ShareSheetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shareIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *shareLable;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, retain) SSDKPlatform *plateform;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewLeftToSuperLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerTopToSuperTop;



- (void)updateCellWithPlatform:(SSDKPlatform *)plateform;

@end
