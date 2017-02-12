 //
//  TopicCell.m
//  FreeLimitProject
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import "TopicCell.h"

@implementation TopicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self creatCell];
    }
    return self;
}

-(void)creatCell{

    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame: self.contentView.frame];
    bgImageView.image = [UIImage imageNamed: @"topic_Cell_Bg"];
    [self setBackgroundView: bgImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 15, 320, 30)];
    [_titleLabel setFont: [UIFont systemFontOfSize: 18]];
    [self.contentView addSubview: _titleLabel];
    
    _imgImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10, 50, 122, 186)];
    [self.contentView addSubview: _imgImageView];
    
    _showview1 = [[TopicShowView alloc] initWithFrame: CGRectMake(140, 50, 160, 50)];
    [self.contentView addSubview: _showview1];
    
    _showview2 = [[TopicShowView alloc] initWithFrame: CGRectMake(140, 50 + 50 * 1, 160, 50)];
    [self.contentView addSubview: _showview2];
    
    _showview3 = [[TopicShowView alloc] initWithFrame: CGRectMake(140, 50 + 50 * 2, 160, 50)];
    [self.contentView addSubview: _showview3];
    
    _showview4 = [[TopicShowView alloc] initWithFrame: CGRectMake(140, 50 + 50 * 3, 160, 50)];
    [self.contentView addSubview: _showview4];
    
    _desc_imgImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10, 260, 40, 40)];
    [self.contentView addSubview: _desc_imgImageView];
    
    _descLabel = [[UILabel alloc] initWithFrame: CGRectMake(60, 260, 240, 40)];
    [_descLabel setFont: [UIFont systemFontOfSize: 12]];
    _descLabel.numberOfLines = 0;
    [self.contentView addSubview: _descLabel];
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

@end
