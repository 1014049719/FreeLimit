//
//  Detailview.m
//  FreeLimitProject
//
//  Created by qianfeng on 15-1-5.
//  Copyright (c) 2015年 hubei. All rights reserved.
//

#import "Detailview.h"

@implementation Detailview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

-(void)createUI{

    UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 300, 280)];
    mainImageView.image=[UIImage imageNamed:@"appdetail_background.png"];
    

    
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
