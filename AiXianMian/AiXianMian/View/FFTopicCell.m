//
//  FFTopicCell.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "FFTopicCell.h"
#import "TopicButton.h"

@implementation FFTopicCell

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
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topic_Cell_Bg.png"]];
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 320, 30)];
    _labelTitle.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_labelTitle];
    
    _imageViewImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 122, 186)];
    [self.contentView addSubview:_imageViewImg];
    
    _arrAppShowView = [[NSMutableArray alloc] init];
    for(int i = 0; i < 4; i ++)
    {
        TopicButton * btn = [[TopicButton alloc] initWithFrame:CGRectMake(140, 50 + i * 50, 180, 50)];
        [self.contentView addSubview:btn];
        [_arrAppShowView addObject:btn];
    }
    
    _imageViewDesc = [[UIImageView alloc] initWithFrame:CGRectMake(10, 260, 40, 40)];
    [self.contentView addSubview:_imageViewDesc];
    
    _labelDesc = [[UILabel alloc] initWithFrame:CGRectMake(60, 260, 240, 40)];
    _labelDesc.font = [UIFont systemFontOfSize:12];
    _labelDesc.numberOfLines = 3;
    [self.contentView addSubview:_labelDesc];
    
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
