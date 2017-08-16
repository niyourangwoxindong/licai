//
//  ShareSheetView.h
//  renyan
//
//  Created by 杭州自心科技 on 16/7/5.
//  Copyright © 2016年 zixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareSheetCell.h"


@protocol ShareSheetViewDelegate;

@interface ShareSheetView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *tapView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionviewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewBottomToSuperBottom;

@property (retain, nonatomic) UICollectionViewFlowLayout *layout;

@property (retain, nonatomic) NSArray<SSDKPlatform *> *platforms;
@property (assign, nonatomic) id<ShareSheetViewDelegate> delegate;

+ (instancetype)createWithCollectionDelegate:(id<ShareSheetViewDelegate>)delegate;

- (void)closeWithAnimation:(BOOL)animation;
- (void)showInTheView:(UIView *)showView animation:(BOOL)animation;
- (void)updatePlatforms:(NSArray<SSDKPlatform *> *)platforms;

@end

@protocol ShareSheetViewDelegate <NSObject>
@optional

- (void)shareSheetViewdidCancelShare:(ShareSheetView *)view;
- (void)releaseShareSheetView:(ShareSheetView *)view;
- (void)shareSheetViewCollectionView:(UICollectionView *)collectionView didSelectWithIndexPath:(NSIndexPath *)indexPath;

@end
