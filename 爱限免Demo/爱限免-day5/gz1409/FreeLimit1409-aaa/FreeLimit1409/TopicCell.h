//
//  TopicCell.h
//  FreeLimit1409
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TopicAppView.h"

@interface TopicCell : UITableViewCell
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UILabel *descLabel;
@property (strong,nonatomic) UIImageView *descImageView;

@property (copy,nonatomic) NSMutableArray *appViewArray;

//添加block回调
//作用: block定义在viewControler, 能拿到导航控制器
-(void) setAppViewAction:( void (^)(TopicAppView *view, AppModel *model) )action;

@end
