//
//  ZJLabel.m
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "ZJLabel.h"

@implementation ZJLabel

-(void)setStrikeLine
{
    //使用技术:
    // NSMutableAttributedString
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    //删除线
    [attrString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, self.text.length)];
    
    self.attributedText = attrString;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
