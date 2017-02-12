//
//  TopicCell.h
//  FreeLimitProject
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicShowView.h"

@interface TopicCell : UITableViewCell

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * imgImageView;
@property (nonatomic, strong) UIImageView * desc_imgImageView;
@property (nonatomic, strong) UILabel * descLabel;
@property (strong,nonatomic)UILabel *datalabel;

@property (strong,nonatomic)TopicShowView *showview1;
@property (strong,nonatomic)TopicShowView *showview2;
@property (strong,nonatomic)TopicShowView *showview3;
@property (strong,nonatomic)TopicShowView *showview4;




@end
