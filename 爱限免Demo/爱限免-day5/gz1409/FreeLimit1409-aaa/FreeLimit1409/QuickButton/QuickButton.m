//
//  QuickButton.m
//  MyIChat1409
//
//  Created by mac on 14-11-13.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "QuickButton.h"

@implementation QuickButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)btnClick:(UIButton *)button
{
    if(self.action)
    {
        self.action(self);
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


//实现类别
@implementation UIButton (QuickButton)

//作用: 创建一个按钮
//  传入位置frame,标题title
+(UIButton *)systemButtonWithFrame:(CGRect )frame
                             title:(NSString *)title
                            action:( void (^)(UIButton *button) )action
{
    QuickButton *button = [QuickButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.action = action;
    return button;
}
+(UIButton *)imageButtonWithFrame:(CGRect )frame
                            title:(NSString *)title
                            image:(NSString *)image
                           action:( void (^)(UIButton *button) )action
{
    QuickButton *button = [QuickButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.action = action;
    return button;
}
@end


