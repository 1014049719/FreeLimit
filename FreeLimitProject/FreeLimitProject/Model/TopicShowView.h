//
//  TopicShowView.h
//  FreeLimitProject
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicShowView : UIView

@property (nonatomic, strong) UIImageView * iconUrlImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * downloadsLabel;
@property (nonatomic, strong) UILabel * commentLabel;
@property (nonatomic, strong) UIImageView * downloadsImageView;
@property (nonatomic, strong) UIImageView * commentImageView;
@property (nonatomic, strong) StarView * starOverallStartView;

@end
