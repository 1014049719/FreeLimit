//
//  NearByAppView.m
//  FreeLimit1409
//
//  Created by mac on 14-11-28.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "NearByAppView.h"

@implementation NearByAppView

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
    //w:35 h:35+20=55
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    _imageView.layer.cornerRadius = 5;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, 52, 15)];
    _label.font = [UIFont systemFontOfSize:10];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
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
