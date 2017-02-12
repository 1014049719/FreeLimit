//
//  AppShowView.m
//  LoveFree
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import "AppShowView.h"

@implementation AppShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.userInteractionEnabled = NO;
    _iconUrlImageView = [[UIImageView alloc] initWithFrame: CGRectMake(3, 3, 44, 44)];
    [_iconUrlImageView.layer setCornerRadius: 5];
    [_iconUrlImageView.layer setMasksToBounds: YES];
    [self addSubview: _iconUrlImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(50, 0, 200, 20)];
    [_nameLabel setFont: [UIFont systemFontOfSize: 12]];
    [self addSubview: _nameLabel];
    
    _commentImageView = [[UIImageView alloc] initWithFrame: CGRectMake(50, 20, 13, 10)];
    _commentImageView.image = [UIImage imageNamed: @"topic_Comment"];
    [self addSubview: _commentImageView];
    
    _commentLabel = [[UILabel alloc] initWithFrame: CGRectMake(50 + 15, 15, 100, 20)];
    [_commentLabel setFont: [UIFont systemFontOfSize: 12]];
    [self addSubview: _commentLabel];
    
    _downloadsImageView = [[UIImageView alloc] initWithFrame: CGRectMake(103, 20, 10, 10)];
    _downloadsImageView.image = [UIImage imageNamed: @"topic_Download"];
    [self addSubview: _downloadsImageView];
    
    _downloadsLabel = [[UILabel alloc] initWithFrame: CGRectMake(100 + 15, 15, 100, 20)];
    [_downloadsLabel setFont: [UIFont systemFontOfSize: 12]];
    [self addSubview: _downloadsLabel];
    
    _starOverallStartView = [[StarView alloc] initWithFrame: CGRectMake(50, 30, 80, 10)];
    [self addSubview: _starOverallStartView];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DetailViewController * detailVC = [[DetailViewController alloc] init];
    detailVC.appId = _applicationId;
    for (UIView * next = [self superview]; next; next = next.superview)
    {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass: [AppListViewController class]]) {
            AppListViewController * appListViewController = (AppListViewController *)nextResponder;
            [appListViewController.navigationController pushViewController:detailVC animated: YES];
            break;
        }
    }
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
