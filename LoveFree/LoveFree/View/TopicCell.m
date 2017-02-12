//
//  TopicCell.m
//  LoveFree
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import "TopicCell.h"
#import "AppShowView.h"

@implementation TopicCell

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
#pragma mark 专题cell视图创建

- (void)createCellUI
{
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame: self.contentView.frame];
    bgImageView.image = [UIImage imageNamed: @"topic_Cell_Bg"];
    [self setBackgroundView: bgImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 15, 320, 30)];
    [_titleLabel setFont: [UIFont systemFontOfSize: 18]];
    [self.contentView addSubview: _titleLabel];
    
    _imgImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10, 50, 122, 186)];
    [self.contentView addSubview: _imgImageView];
    
    _appShowView1 = [[AppShowView alloc] initWithFrame: CGRectMake(140, 50, 160, 50)];
    [self.contentView addSubview: _appShowView1];
    
    _appShowView2 = [[AppShowView alloc] initWithFrame: CGRectMake(140, 50 + 50 * 1, 160, 50)];
    [self.contentView addSubview: _appShowView2];
    
    _appShowView3 = [[AppShowView alloc] initWithFrame: CGRectMake(140, 50 + 50 * 2, 160, 50)];
    [self.contentView addSubview: _appShowView3];
    
    _appShowView4 = [[AppShowView alloc] initWithFrame: CGRectMake(140, 50 + 50 * 3, 160, 50)];
    [self.contentView addSubview: _appShowView4];
    
    _desc_imgImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10, 260, 40, 40)];
    [self.contentView addSubview: _desc_imgImageView];
    
    _descLabel = [[UILabel alloc] initWithFrame: CGRectMake(60, 260, 240, 40)];
    [_descLabel setFont: [UIFont systemFontOfSize: 12]];
    _descLabel.numberOfLines = 0;
    [self.contentView addSubview: _descLabel];
}

#pragma mark -

@end
