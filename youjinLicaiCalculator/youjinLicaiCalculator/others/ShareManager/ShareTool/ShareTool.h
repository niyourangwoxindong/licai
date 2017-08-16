//
//  ShareTool.h
//  YouJin
//
//  Created by 柚今科技02 on 2017/5/23.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/SSDKTypeDefine.h>

@interface ShareTool : NSObject

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *urlResource;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *sharetext;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) id objcid;
@property (nonatomic, assign) SSDKPlatformType type;


@end
