//
//  QuickButton.h
//  MyIChat1409
//
//  Created by mac on 14-11-13.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickButton : UIButton
//UIButton事件处理使用方法
//改写为block
//事件响应函数 void action(UIButton *button)
@property (nonatomic,copy) void (^action)(UIButton *button);
@end

//为系统的UIButton添加一个创建按钮的快捷方式
@interface UIButton (QuickButton)

//作用: 创建一个按钮
//  传入位置frame,标题title
+(UIButton *)systemButtonWithFrame:(CGRect )frame
                             title:(NSString *)title
                            action:( void (^)(UIButton *button) )action;

+(UIButton *)imageButtonWithFrame:(CGRect )frame
                             title:(NSString *)title
                            image:(NSString *)image
                            action:( void (^)(UIButton *button) )action;
@end




