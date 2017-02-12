//
//  TopicButton.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "TopicButton.h"

@implementation TopicButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 44, 44)];
    [self addSubview:_imageViewIcon];
    
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 120, 20)];
    _labelName.font = [UIFont boldSystemFontOfSize:13];
    [self addSubview:_labelName];
    
    UIImageView * commentView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 18, 13, 9)];
    commentView.image = [UIImage imageNamed:@"topic_Comment.png"];
    [self addSubview:commentView];
    
    _labelComment = [[UILabel alloc] initWithFrame:CGRectMake(65, 15, 100, 20)];
    _labelComment.font = [UIFont systemFontOfSize:12];
    [self addSubview:_labelComment];
    
    UIImageView * downloadView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 18, 10, 11)];
    downloadView.image = [UIImage imageNamed:@"topic_Download.png"];
    [self addSubview:downloadView];
    
    _labelDownloads = [[UILabel alloc] initWithFrame:CGRectMake(113, 18, 50, 11)];
    _labelDownloads.font = [UIFont systemFontOfSize:12];
    [self addSubview:_labelDownloads];
    
    _starView = [[StarView alloc] init];
    _starView.frame = CGRectMake(50, 30, 80, 10);
    [self addSubview:_starView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
