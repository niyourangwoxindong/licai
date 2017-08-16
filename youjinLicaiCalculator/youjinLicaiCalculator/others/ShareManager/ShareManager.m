//
//  ShareManager.m
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ShareManager.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import "ShareSheetView.h"
#import "ShareTool.h"
#import "NSMutableDictionary+Utilities.h"
#import <MobLink/UIViewController+MLSDKRestore.h>
#import <MobLink/MobLink.h>

@interface ShareManager ()<ShareSheetViewDelegate>

@property (nonatomic, retain) ShareTool *tool;
@property (nonatomic, retain) ShareSheetView *shareSheetView;

@end

@implementation ShareManager



+ (instancetype)shareManagerStandardWithDelegate:(id<ShareManagerDelegate>)delegate {
    static ShareManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[ShareManager alloc] init];
    });
    manager.delegate = delegate;
    return manager;
}


- (void)registShareSDK {
    [ShareSDK registerActivePlatforms:[self activePlatforms] onImport:^(SSDKPlatformType platformType) {
        [self importWithPlatformType:platformType];
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        [self configureWithPlatformType:platformType appInfo:appInfo];
    }];
}


#pragma mark - share

- (void)shareInView:(UIView *)view text:(NSString *)text image:(id)image url:(NSString *)url title:(NSString *)title objid:(NSNumber *)objid isNeedMobLink:(BOOL)isNeedMobLink path:(NSString *)path params:(NSDictionary *)params mobid:(NSString *)cacheMobid result:(void (^)(NSString *mobid))result {
    if (!isNeedMobLink) {
        [self shareInView:view text:text image:image url:url title:title objid:objid];
    }else {
        if (cacheMobid) {
            [self shareInView:view text:text image:image url:url title:title objid:objid path:path mobId:cacheMobid];
        }else {
            [self getMobidWithPath:path source:@"" params:params result:^(NSString *mobid) {
                if (mobid && result) {
                    result(mobid);
                }
                [self shareInView:view text:text image:image url:url title:title objid:objid path:path mobId:mobid];
            }];
        }
    }
}

- (void)shareInView:(UIView *)view text:(NSString *)text image:(id)image url:(NSString *)url title:(NSString *)title objid:(NSNumber *)objid {
    self.tool.title = title;
    self.tool.url = url;
    self.tool.sharetext = text;
    self.tool.image = image;
    self.tool.objcid = objid;
    
    self.shareSheetView = [ShareSheetView createWithCollectionDelegate:self];
    [self.shareSheetView showInTheView:view animation:YES];
}

- (void)shareInView:(UIView *)view text:(NSString *)text image:(id)image url:(NSString *)url title:(NSString *)title objid:(NSNumber *)objid path:(NSString *)path mobId:(NSString *)mobid{
    NSString *urlString = [self linkUrlStringWithPath:path mobId:mobid initialUrl:url];
    [self shareInView:view text:text image:image url:urlString title:title objid:objid];
}



- (void)cacheMobid:(NSString *)mobid forKeyPath:(NSString *)keyPath {
    [[NSUserDefaults standardUserDefaults] setObject:mobid forKey:keyPath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)mobidForKeyPath:(NSString *)keyPath {
    return [[NSUserDefaults standardUserDefaults] objectForKey:keyPath];
}

- (void)getMobidWithPath:(NSString *)path
                  source:(NSString *)source
                  params:(NSDictionary *)params
                  result:(void (^)(NSString *mobid))result
{
    MLSDKScene *scene = [[MLSDKScene alloc] initWithMLSDKPath:path source:source params:params];
    
    [MobLink getMobId:scene result:result];
}



#pragma mark - login

- (void)loginWithPlatformType:(SSDKPlatformType)type {
    [ShareSDK authorize:type settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:{
                if ([self.delegate respondsToSelector:@selector(shareManager: loginSuccessWithResponse: platform:)]) {
                    [self.delegate shareManager:self loginSuccessWithResponse:user platform:type];
                }
            }
                break;
            case SSDKResponseStateFail: {
                if ([self.delegate respondsToSelector:@selector(shareManager: loginFailWithError: platform:)]) {
                    [self.delegate shareManager:self loginFailWithError:error platform:type];
                }
            }
                break;
            case SSDKResponseStateCancel: {
                if ([self.delegate respondsToSelector:@selector(shareManagerLoginDidCancel: platform:)]) {
                    [self.delegate shareManagerLoginDidCancel:self platform:type];
                }
            }
                break;
            default:
                break;
        }
    }];
}


#pragma mark - reget 

- (ShareTool *)tool {
    if (!_tool) {
        _tool = [[ShareTool alloc]init];
    }
    return _tool;
}


#pragma mark - <ShareSheetViewDelegate>

- (void)shareSheetViewdidCancelShare:(ShareSheetView *)view {
    if ([self.delegate respondsToSelector:@selector(shareManagerdDidCloseShareSheetView:)]) {
        [self.delegate shareManagerdDidCloseShareSheetView:self];
    }
    
}
- (void)releaseShareSheetView:(ShareSheetView *)view {
    self.shareSheetView = nil;
}
- (void)shareSheetViewCollectionView:(UICollectionView *)collectionView didSelectWithIndexPath:(NSIndexPath *)indexPath {
    [self.shareSheetView closeWithAnimation:NO];
    ShareSheetCell *cell = (ShareSheetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self shareActionWithPlatformType:cell.plateform.type];
}



#pragma mark - publicMethod

- (NSDictionary *)keyValuesWithUserInfo:(SSDKUser *)user platform:(SSDKPlatformType) platform {
    NSMutableDictionary *extractDic = [NSMutableDictionary dictionary];
    NSDictionary *dic = [user.rawData mutableCopy];
    [extractDic setNewObject:dic[@"nickname"] forKey:@"nickname"];
    [extractDic setNewObject:dic[@"openid"] forKey:@"openid"];
    [extractDic setNewObject:dic[@"unionid"] forKey:@"unionid"];
    [extractDic setNewObject:dic[@"sex"] forKey:@"sex"];
    [extractDic setNewObject:dic[@"city"] forKey:@"city"];
    [extractDic setNewObject:dic[@"province"] forKey:@"province"];
    [extractDic setNewObject:dic[@"country"] forKey:@"country"];
    [extractDic setNewObject:dic[@"headimgurl"] forKey:@"head_image"];
    return extractDic;
}


#pragma mark - helpMethod


- (void)shareActionWithPlatformType:(SSDKPlatformType)type {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    SSDKContentType contentType = SSDKContentTypeAuto;
    if (type == SSDKPlatformTypeSinaWeibo) {
        if (self.tool.url || self.tool.url.length > 0) {
            contentType = SSDKContentTypeWebPage;
        }
    }
    [shareParams SSDKSetupShareParamsByText:self.tool.sharetext
                                     images:self.tool.image
                                        url:[NSURL URLWithString:self.tool.url]
                                      title:self.tool.title
                                       type:contentType];
    [shareParams SSDKEnableUseClientShare];
    [ShareSDK share:type
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess: {
                 [self handleShareSuccessPlatformType:type];
             }
                 break;
             case SSDKResponseStateFail: {
                 [self handleShareFailWithError:error];
             }
                 break;
             case SSDKResponseStateCancel: {
                 [self handleShareCancel];
             }
                 break;
             default:
                 break;
         }
     }];

}


- (NSArray *)activePlatforms {
    return @[
             @(SSDKPlatformSubTypeWechatSession),
             @(SSDKPlatformSubTypeWechatTimeline),
             @(SSDKPlatformTypeSinaWeibo),
             @(SSDKPlatformTypeQQ),
             @(SSDKPlatformSubTypeQZone),
             @(SSDKPlatformTypeWechat)
             ];
}

- (void)importWithPlatformType:(SSDKPlatformType)type {
    switch (type) {
        case SSDKPlatformTypeWechat:
        case SSDKPlatformSubTypeWechatTimeline:
        case SSDKPlatformSubTypeWechatSession:
            [ShareSDKConnector connectWeChat:[WXApi class]];
            break;
        case SSDKPlatformSubTypeQZone:
        case SSDKPlatformTypeQQ:
            [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
            break;
        case SSDKPlatformTypeSinaWeibo:
            [ShareSDKConnector connectWeibo:[WeiboSDK class]];
            break;
        default:
            break;
    }
}

- (void)configureWithPlatformType:(SSDKPlatformType)type appInfo:(NSMutableDictionary *)appInfo {
    switch (type) {
        case SSDKPlatformTypeSinaWeibo:
            [appInfo SSDKSetupSinaWeiboByAppKey:@"4201631474"
                                      appSecret:@"8e38d9a2782fe2b8b7b2696e0845ff0b"
                                    redirectUri:@"http://www.sharesdk.cn"
                                       authType:SSDKAuthTypeBoth];
            break;
        case SSDKPlatformTypeWechat:
            [appInfo SSDKSetupWeChatByAppId:@" wx9c0043e62e920b44"
                                  appSecret:@"6986c503ddd6c8b7683bb4c9eb5cebd6"];
            break;
        case SSDKPlatformTypeQQ:
            [appInfo SSDKSetupQQByAppId:@"1106173977"
                                 appKey:@"v0tt5Lr4xiJWz9uS"
                               authType:SSDKAuthTypeSSO];
            break;
        default:
            break;
    }

}



- (void)handleShareSuccessPlatformType:(SSDKPlatformType)platformType {
    [self hideKeyboard];
    if (self.tool && self.tool.objcid && ![self.tool.objcid isKindOfClass:[NSNull class]]) {
        [self requestForAddUmoney];
    }
    if ([self.delegate respondsToSelector:@selector(shareManagerShareDidSuccess:)]) {
        [self.delegate shareManagerShareDidSuccess:self];
    }
}

- (void)handleShareFailWithError:(NSError *)error {
    [self hideKeyboard];
    if ([self.delegate respondsToSelector:@selector(shareManager: shareDidFailWithError:)]) {
        [self.delegate shareManager:self shareDidFailWithError:error];
    }
}

- (void)handleShareCancel {
    [self hideKeyboard];
    if ([self.delegate respondsToSelector:@selector(shareManagerShareDidCancel:)]) {
        [self.delegate shareManagerShareDidCancel:self];
    }
}


- (void)hideKeyboard {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        [window endEditing:YES];
    }
}


- (NSString *)linkUrlStringWithPath:(NSString *)path mobId:(NSString *)mobid initialUrl:(NSString *)initialUrlString {
    NSString *urlString = nil;
    NSURL *url = [NSURL URLWithString:initialUrlString];
    urlString = url.query.length > 0 ? [initialUrlString stringByAppendingString:@"&"] : [initialUrlString stringByAppendingString:@"?"];
    urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"path=%@&mobid=%@",path,mobid]];
    return urlString;
}

#pragma mark - require

- (void)requestForAddUmoney {
//    if (!USERSid) return;
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setNewObject:tokenString forKey:@"at"];
//    [param setNewObject:USERUID forKey:@"uid"];
//    [param setNewObject:self.tool.objcid forKey:@"type"];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager bo_manager];
//    [manager POST:[NSString stringWithFormat:@"%@Common/pushUbiByShare",BASEURL] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
}


@end
