//
//  FFCell.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "FFCell.h"

@implementation FFCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 60, 60)];
    [self.contentView addSubview:_imageViewIcon];

    _imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self.contentView addSubview:_imageViewBack];
    
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 250, 20)];
    _labelName.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_labelName];
    
    _labelOther = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 100, 20)];
    _labelOther.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelOther];
    
    _starView = [[StarView alloc] initWithFrame:CGRectMake(80, 52, 100, 30)];
    [self.contentView addSubview:_starView];
    
    _labelLastPrice = [[UILabel alloc] initWithFrame:CGRectMake(220, 25, 60, 20)];
    _labelLastPrice.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelLastPrice];
    
    UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(210, 25, 60, 20)];
    lineView.image = [UIImage imageNamed:@"line.png"];
    [self.contentView addSubview:lineView];
    
    _labelCategoryName = [[UILabel alloc] initWithFrame:CGRectMake(220, 48, 60, 25)];
    [self.contentView addSubview:_labelCategoryName];
    
    _labelShares = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 80, 20)];
    _labelShares.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelShares];
    
    _labelFavorites = [[UILabel alloc] initWithFrame:CGRectMake(100, 75, 80, 20)];
    _labelFavorites.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelFavorites];
    
    _labelDownloads = [[UILabel alloc] initWithFrame:CGRectMake(190, 75, 100, 20)];
    _labelDownloads.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelDownloads];
    
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
