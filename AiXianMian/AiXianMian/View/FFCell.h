//
//  FFCell.h
//  AiXianMian
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

//限免、降价、免费、热榜页面的cell

@interface FFCell : UITableViewCell

@property (nonatomic, strong) UIImageView * imageViewIcon;

@property (nonatomic, strong) UILabel * labelName;

@property (nonatomic, strong) UILabel * labelLastPrice;

@property (nonatomic, strong) UILabel * labelOther;

@property (nonatomic, strong) StarView * starView;

@property (nonatomic, strong) UILabel * labelCategoryName;

@property (nonatomic, strong) UILabel * labelShares;

@property (nonatomic, strong) UILabel * labelFavorites;

@property (nonatomic, strong) UILabel * labelDownloads;

@property (nonatomic, strong) UIImageView * imageViewBack;


@end
