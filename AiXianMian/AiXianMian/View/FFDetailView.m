//
//  FFDetailView.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "FFDetailView.h"

@implementation FFDetailView

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
    UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 300, 280)];
    mainImageView.image = [UIImage imageNamed:@"appdetail_background.png"];
    mainImageView.userInteractionEnabled = YES;
    [self addSubview:mainImageView];
    
    _imageViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    _imageViewIcon.layer.cornerRadius = 10;
    _imageViewIcon.clipsToBounds = YES;
    [mainImageView addSubview:_imageViewIcon];
    
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(90, 8, 200, 30)];
    _labelName.font = [UIFont boldSystemFontOfSize:16];
    [mainImageView addSubview: _labelName];
    
    _labelLastPrice = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 150, 20)];
    _labelLastPrice.font = [UIFont systemFontOfSize:14];
    [mainImageView addSubview:_labelLastPrice];
    
    _labelFileSize = [[UILabel alloc] initWithFrame:CGRectMake(200, 40, 80, 20)];
    _labelFileSize.font = [UIFont systemFontOfSize:14];
    [mainImageView addSubview:_labelFileSize];
    
    _labelCategoryName = [[UILabel alloc] initWithFrame:CGRectMake(90, 60, 120, 20)];
    _labelCategoryName.font = [UIFont systemFontOfSize:14];
    [mainImageView addSubview:_labelCategoryName];
    
    _labelstarCurrent = [[UILabel alloc] initWithFrame:CGRectMake(200, 60, 100, 20)];
    _labelstarCurrent.font = [UIFont systemFontOfSize:14];
    [mainImageView addSubview:_labelstarCurrent];
    
    _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnShare.frame = CGRectMake(0, 90, 100, 40);
    [_btnShare setBackgroundImage:[UIImage imageNamed:@"Detail_btn_left.png"] forState:UIControlStateNormal];
    [_btnShare setTitle:@"分享" forState:UIControlStateNormal];
    [_btnShare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnShare setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [mainImageView addSubview:_btnShare];
    
    _btnFavorites = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnFavorites.frame = CGRectMake(100, 90, 100, 40);
    [_btnFavorites setBackgroundImage:[UIImage imageNamed:@"Detail_btn_middle.png"] forState:UIControlStateNormal];
    [_btnFavorites setTitle:@"收藏" forState:UIControlStateNormal];
    [_btnFavorites setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnFavorites setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [mainImageView addSubview:_btnFavorites];
    
    _btnDownload = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDownload.frame = CGRectMake(200, 90, 98, 40);
    [_btnDownload setBackgroundImage:[UIImage imageNamed:@"Detail_btn_right.png"] forState:UIControlStateNormal];
    [_btnDownload setTitle:@"下载" forState:UIControlStateNormal];
    [_btnDownload setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnDownload setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [mainImageView addSubview:_btnDownload];
    
    _scrollViewPhotos = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 135, 280, 88)];
    [mainImageView addSubview:_scrollViewPhotos];
    
    _labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 282, 50)];
    _labelDescription.font = [UIFont systemFontOfSize:10];
    _labelDescription.numberOfLines = 3;
    [mainImageView addSubview:_labelDescription];
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 282, 300, 90)];
    bottomImageView.image = [UIImage imageNamed:@"appdetail_recommend.png"];
    bottomImageView.userInteractionEnabled = YES;
    [self addSubview:bottomImageView];
    
    _scrollViewArround = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, 282, 80)];
    [bottomImageView addSubview:_scrollViewArround];
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
