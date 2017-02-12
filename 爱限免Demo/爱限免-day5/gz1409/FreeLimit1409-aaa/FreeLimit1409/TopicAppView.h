//
//  TopicAppView.h
//  FreeLimit1409
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StarView.h"

#import "AppModel.h"

@interface TopicAppView : UIView
@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UILabel *nameLabel;
@property (strong,nonatomic) UILabel *commentLabel;
@property (strong,nonatomic) UILabel *downloadLabel;
@property (strong,nonatomic) StarView *starView;

//属性
//作用:  TopicAppView 和 AppModel 对应起来了
@property (strong,nonatomic) AppModel *model;
@end
