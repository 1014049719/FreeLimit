//
//  ClassifyCell.m
//  LoveFree
//
//  Created by qianfeng on 14-12-31.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import "ClassifyCell.h"

@implementation ClassifyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createUI];
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
#pragma mark 创建分类cell的视图

- (void)createUI
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame: self.contentView.frame];
    imageView.image = [UIImage imageNamed: @"cate_list_bg"];
    self.backgroundView = imageView;
    
    UIImageView * selectedImageView = [[UIImageView alloc] initWithFrame: self.contentView.frame];
    selectedImageView.image = [UIImage imageNamed: @"cate_list_bg2"];
    self.selectedBackgroundView = selectedImageView;
    
    _iconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(15, 7, 60, 60)];
    [_iconImageView.layer setCornerRadius: 10];
    [_iconImageView.layer setMasksToBounds: YES];
    [self.contentView addSubview: _iconImageView];
    
    _categoryNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(80, 10, 100, 30)];
    [self.contentView addSubview: _categoryNameLabel];
    
    _categoryDetailLabel = [[UILabel alloc] initWithFrame: CGRectMake(80, 40, 300, 30)];
    _categoryDetailLabel.font = [UIFont systemFontOfSize: 12];
    [self.contentView addSubview: _categoryDetailLabel];
}

#pragma mark -


@end
