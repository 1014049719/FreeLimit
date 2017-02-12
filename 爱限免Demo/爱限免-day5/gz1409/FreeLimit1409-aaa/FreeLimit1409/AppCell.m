//
//  AppCell.m
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    //320x100
    //添加背景图片
    _back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    _back.image = [UIImage imageNamed:@"cate_list_bg1.png"];
    self.backgroundView = _back;
    
    //
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 10, 60, 60)];
    //圆角效果
    _iconImageView.layer.cornerRadius = 8;
    _iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 200, 30)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 25, 200, 30)];
    _infoLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_infoLabel];
    
    _starView = [[StarView alloc] initWithFrame:CGRectMake(80, 50, 100, 30)];
    [self.contentView addSubview:_starView];
    
    _priceLabel = [[ZJLabel alloc] initWithFrame:CGRectMake(240, 25, 200, 30)];
    [self.contentView addSubview:_priceLabel];
    
    _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 45, 200, 30)];
    [self.contentView addSubview:_categoryLabel];
    
    _shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 200, 30)];
    _shareLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_shareLabel];
    
    _favoriteLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 70, 200, 30)];
    _favoriteLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_favoriteLabel];
    
    _downloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 70, 200, 30)];
    _downloadLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_downloadLabel];
    
    
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
