//
//  AppShowView.h
//  LoveFree
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoveFree-Prefix.pch"

@interface AppShowView : UIView

@property (nonatomic, strong) NSString * applicationId;
@property (nonatomic, strong) UIImageView * iconUrlImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * downloadsLabel;
@property (nonatomic, strong) UILabel * commentLabel;
@property (nonatomic, strong) UIImageView * downloadsImageView;
@property (nonatomic, strong) UIImageView * commentImageView;
@property (nonatomic, strong) StarView * starOverallStartView;

@end
