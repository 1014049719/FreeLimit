//
//  CategoryCell.m
//  FreeLimit1409
//
//  Created by mac on 14-11-28.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

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
    /*
    CategoryCell			0,0,320,80	cate_list_bg.png
	_iconImageView			15, 7, 60, 60
	_categoryNameLabel		80, 10, 100, 30
	_categoryDetailLabel	80, 40, 300, 30
    
	分类图片名:
    如果分类名为 Game, 则图片为 category_Game.jpg
     */
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    back.image = [UIImage imageNamed:@"cate_list_bg.png"];
    self.backgroundView = back;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 60, 60)];
    _iconImageView.layer.cornerRadius = 10;
    _iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
    _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_nameLabel];
    
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 200, 30)];
    _detailLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_detailLabel];
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
