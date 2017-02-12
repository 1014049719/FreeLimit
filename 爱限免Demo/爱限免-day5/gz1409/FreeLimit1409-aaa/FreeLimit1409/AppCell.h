//
//  AppCell.h
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StarView/StarView.h"
#import "ZJLabel.h"

@interface AppCell : UITableViewCell
@property (strong,nonatomic) UIImageView *back;
@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *infoLabel;
@property (strong,nonatomic) StarView *starView;
@property (strong,nonatomic) ZJLabel *priceLabel;
@property (strong,nonatomic) UILabel *categoryLabel;
@property (strong,nonatomic) UILabel *shareLabel;
@property (strong,nonatomic) UILabel *favoriteLabel;
@property (strong,nonatomic) UILabel *downloadLabel;
//星级评价
@end



