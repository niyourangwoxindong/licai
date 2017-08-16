//
//  ChakanTableViewCell.m
//  YouJin
//
//  Created by 柚今科技01 on 2017/6/15.
//  Copyright © 2017年 youjin. All rights reserved.
//

#import "ChakanTableViewCell.h"

@implementation ChakanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _qishuLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110*BOScreenW/750, 78*BOScreenH/1334)];
//        qishuLabel.text = @"1";
        _qishuLabel.textColor = [UIColor colorWithHexString:@"#56a0fe" alpha:1];
        _qishuLabel.font = [UIFont systemFontOfSize:13];
        _qishuLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_qishuLabel];
        
        _benjinLabel = [[UILabel alloc]initWithFrame:CGRectMake(164*BOScreenW/750, 0, 150*BOScreenW/750, 78*BOScreenH/1334)];
//        _benjinLabel.text = @"0";
        _benjinLabel.textColor = [UIColor colorWithHexString:@"#56a0fe" alpha:1];
        _benjinLabel.font = [UIFont systemFontOfSize:13];
        _benjinLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_benjinLabel];
        
        _lixiLabel = [[UILabel alloc]initWithFrame:CGRectMake(346*BOScreenW/750, 0, 160*BOScreenW/750, 78*BOScreenH/1334)];
//        _lixiLabel.text = @"10.4";
        _lixiLabel.textColor = [UIColor colorWithHexString:@"#56a0fe" alpha:1];
        _lixiLabel.font = [UIFont systemFontOfSize:13];
        _lixiLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lixiLabel];
        
        _hkriqiLabel = [[UILabel alloc]initWithFrame:CGRectMake(510*BOScreenW/750, 0, 220*BOScreenW/750, 78*BOScreenH/1334)];
//        _hkriqiLabel.text = @"2017.04.28";
        _hkriqiLabel.textColor = [UIColor colorWithHexString:@"#56a0fe" alpha:1];
        _hkriqiLabel.font = [UIFont systemFontOfSize:13];
        _hkriqiLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_hkriqiLabel];
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 77*BOScreenH/1334, BOScreenW, 1*BOScreenH/1334)];
        lineview.backgroundColor = [UIColor colorWithHexString:@"#e4e8eb" alpha:1];
        [self.contentView addSubview:lineview];
    }
    return self;
}
@end
