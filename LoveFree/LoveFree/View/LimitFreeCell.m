//
//  LimitFreeCell.m
//  LoveFree
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import "LimitFreeCell.h"
#import "StarView.h"

@implementation LimitFreeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createCellUI];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark 限免cell视图创建

- (void)createCellUI
{
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame: self.contentView.frame];
    bgImageView.image = [UIImage imageNamed: @"cate_list_bg2"];
    [self setBackgroundView: bgImageView];
    UIImageView * bgSelectedImageView = [[UIImageView alloc] initWithFrame: self.contentView.frame];
    bgSelectedImageView.image = [UIImage imageNamed: @"cate_list_bg1"];
    [self setSelectedBackgroundView: bgSelectedImageView];
    
    _iconUrlImageView = [[UIImageView alloc] initWithFrame: CGRectMake(15, 10, 60, 60)];
    [_iconUrlImageView.layer setCornerRadius: 10];
    [_iconUrlImageView.layer setMasksToBounds: YES];
    
    _starCurrentStarView = [[StarView alloc] initWithFrame: CGRectMake(85, 38, 100, 30)];
    [self.contentView addSubview: _starCurrentStarView];
    
    _nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(85, 10, 230, 20)];
    _lastPriceLabel = [[UILabel alloc] initWithFrame: CGRectMake(220, 30, 60, 20)];
    _categoryNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(220, 50, 100, 20)];
    _sharesLabel = [[UILabel alloc] initWithFrame: CGRectMake(15, 75, 80, 20)];
    _favoritesLabel = [[UILabel alloc] initWithFrame: CGRectMake(100, 75, 80, 20)];
    _downloadsLabel = [[UILabel alloc] initWithFrame: CGRectMake(185, 75, 135, 20)];
    
    [self.contentView addSubview: _iconUrlImageView];
    [self.contentView addSubview: _nameLabel];
    [self.contentView addSubview: _lastPriceLabel];
    [self.contentView addSubview: _categoryNameLabel];
    [self.contentView addSubview: _sharesLabel];
    [self.contentView addSubview: _favoritesLabel];
    [self.contentView addSubview: _downloadsLabel];
}

#pragma mark -

@end
