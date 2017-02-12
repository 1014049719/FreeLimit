//
//  TopicButton.h
//  AiXianMian
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicButton : UIButton

@property (nonatomic, strong) UIImageView * imageViewIcon;

@property (nonatomic, strong) UILabel * labelName;

@property (nonatomic, strong) StarView * starView;

@property (nonatomic, strong) UILabel * labelDownloads;

@property (nonatomic, strong) UILabel * labelComment;

@property (nonatomic, strong) NSString * applicationId;

@end
