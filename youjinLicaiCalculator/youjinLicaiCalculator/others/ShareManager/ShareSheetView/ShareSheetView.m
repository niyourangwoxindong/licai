//
//  ShareSheetView.m
//  renyan
//
//  Created by 杭州自心科技 on 16/7/5.
//  Copyright © 2016年 zixin. All rights reserved.
//

#import "ShareSheetView.h"

@interface ShareSheetView ()

@end

@implementation ShareSheetView

+ (instancetype)createWithCollectionDelegate:(id<ShareSheetViewDelegate>)delegate {
    ShareSheetView *view = [[NSBundle mainBundle] loadNibNamed:@"ShareSheetView" owner:nil options:nil].firstObject;
    view.delegate = delegate;
    return view;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCollectionLayout];
    [self configureViews];
}

- (void)configureViews {
    self.frame = CGRectMake(0, 0, [UIScreen screenWidth], [UIScreen screenHeight]);
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.tapView addGestureRecognizer:tap];
    [self configureCollectionView];
}

- (void)configureCollectionView {
    [self configureCollectionLayout];
    self.collectionView.collectionViewLayout = self.layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ShareSheetCell" bundle:nil] forCellWithReuseIdentifier:kshareSheetCellIdentifier];
}

- (void)configureCollectionLayout {
    self.layout = [[UICollectionViewFlowLayout alloc]init];
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.sectionInset = UIEdgeInsetsMake(0, DEFAULT_SCREEN_RATIO * 10, 0, DEFAULT_SCREEN_RATIO * 10);
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = CGSizeMake(([UIScreen screenWidth] - self.layout.sectionInset.left * 2) / 5.0, 120 * DEFAULT_SCREEN_RATIO);
}

- (void)layoutConstraintConfigure {
    self.collectionviewHeight.constant = 120 * DEFAULT_SCREEN_RATIO;
    self.backViewHeight.constant = 170 * DEFAULT_SCREEN_RATIO;
}

#pragma mark - publicMethod
- (void)updatePlatforms:(NSArray *)platforms {
    self.platforms = platforms;
    [self.collectionView reloadData];
}

#pragma mark - buttonAction
- (IBAction)cancelAction:(UIButton *)sender {
    [self closeWithAnimation:YES];
}

#pragma mark - gestureAction

- (void)tapAction:(UITapGestureRecognizer *)sender {
    [self closeWithAnimation:YES];
}

#pragma mark - reget 

- (NSArray<SSDKPlatform *> *)platforms {
    if (!_platforms) {
        _platforms = [self cretaeSSDKPlateformWithPlatformTypes:@[
                                                                 @(SSDKPlatformTypeWechat),
                                                                 @(SSDKPlatformSubTypeWechatTimeline),
                                                                 @(SSDKPlatformTypeQQ),
                                                                 @(SSDKPlatformSubTypeQZone),
                                                                 @(SSDKPlatformTypeSinaWeibo),
                                                                 ]];
    }
    return _platforms;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.platforms.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShareSheetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kshareSheetCellIdentifier forIndexPath:indexPath];
    [cell updateCellWithPlatform:self.platforms[indexPath.row]];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(shareSheetViewCollectionView: didSelectWithIndexPath:)]) {
        [self.delegate shareSheetViewCollectionView:collectionView didSelectWithIndexPath:indexPath];
    }
}

#pragma  mark - helpMethod
- (void)showInTheView:(UIView *)showView animation:(BOOL)animation {
    [showView.window addSubview:self];
    if (animation) {
        self.containerView.layer.transform = CATransform3DMakeTranslation(0, (170 * DEFAULT_SCREEN_RATIO), 0);
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
            self.containerView.layer.transform = CATransform3DMakeTranslation(0, 0, 0);
        } completion:nil];
    }else {
    }
}


- (void)closeWithAnimation:(BOOL)animation {
    if (animation) {
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^ {
            self.containerView.layer.transform = CATransform3DMakeTranslation(0, (170 * DEFAULT_SCREEN_RATIO), 0);
        } completion:^(BOOL finished) {
            [self removeSubView];
        }];
    }else {
        [self removeSubView];
    }
    if ([self.delegate respondsToSelector:@selector(shareSheetViewdidCancelShare:)]) {
        [self.delegate shareSheetViewdidCancelShare:self];
    }
}



- (void)removeSubView {
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(releaseShareSheetView:)]) {
        [self.delegate releaseShareSheetView:self];
    }
}

- (NSArray<SSDKPlatform *> *)cretaeSSDKPlateformWithPlatformTypes:(NSArray<NSNumber *> *)types {
    NSMutableArray *array = [NSMutableArray array];
    for (NSNumber *type in types) {
        [array addObject:[self cretaeSSDKPlateformWithPlatformType:[type intValue]]];
    }
    return array;
}


- (SSDKPlatform *)cretaeSSDKPlateformWithPlatformType:(SSDKPlatformType)type {
    SSDKPlatform *platform = [[SSDKPlatform alloc]init];
    switch (type) {
        case SSDKPlatformTypeWechat:
            [self platform:platform setIconName:@"ssdk_oks_classic_wechat" text:@"微信" type:SSDKPlatformTypeWechat];
            break;
        case SSDKPlatformSubTypeWechatTimeline:
            [self platform:platform setIconName:@"ssdk_oks_classic_friends" text:@"朋友圈" type:SSDKPlatformSubTypeWechatTimeline];
            break;
        case SSDKPlatformSubTypeQZone:
            [self platform:platform setIconName:@"ssdk_oks_classic_qqzone" text:@"QQ空间" type:SSDKPlatformSubTypeQZone];
            break;
        case SSDKPlatformTypeQQ:
            [self platform:platform setIconName:@"ssdk_oks_classic_qq" text:@"QQ" type:SSDKPlatformTypeQQ];
            break;
        case SSDKPlatformTypeSinaWeibo:
            [self platform:platform setIconName:@"ssdk_oks_classic_sinaweibo" text:@"新浪微博" type:SSDKPlatformTypeSinaWeibo];
            break;
        default:
            break;
    }
    return platform;
}


- (void)platform:(SSDKPlatform *)platform setIconName:(NSString *)name text:(NSString *)text type:(SSDKPlatformType)type {
    platform.icon = [UIImage imageNamed:name];
    platform.name = text;
    platform.type = type;
}


@end
