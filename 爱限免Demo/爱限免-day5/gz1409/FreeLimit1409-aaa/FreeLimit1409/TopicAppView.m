//
//  TopicAppView.m
//  FreeLimit1409
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "TopicAppView.h"

@implementation TopicAppView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    //AppShowView	大小: 160X50
    /*
	_iconImageView	3, 3, 44, 44
	_titleLabel		50, 0, 200, 20
	commentView		50, 18, 13, 9	topic_Comment.png
	_commentLabel	50+13, 15, 100, 20	font=12
	downloadView	100, 18, 10, 11	topic_Download.png
	_downLabel		100+13, 15, 100, 20	font=12
	_starView		50, 30, 80, 10
     */
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 44, 44)];
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.clipsToBounds = YES;
    [self addSubview:_iconImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, 20)];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_nameLabel];
    
    UIImageView *commentView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 21, 13, 9)];
    commentView.image = [UIImage imageNamed:@"topic_Comment.png"];
    [self addSubview:commentView];
    
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+15, 15, 100, 20)];
    _commentLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_commentLabel];
    
    UIImageView *downloadView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 21, 10, 11)];
    downloadView.image = [UIImage imageNamed:@"topic_Download.png"];
    [self addSubview:downloadView];
    
    _downloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(100+13, 15, 100, 20)];
    _downloadLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_downloadLabel];
    
    _starView = [[StarView alloc] initWithFrame:CGRectMake(50, 30, 80, 10)];
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
