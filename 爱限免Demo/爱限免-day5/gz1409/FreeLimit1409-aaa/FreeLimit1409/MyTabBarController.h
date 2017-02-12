//
//  MyTabBarController.h
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarController : UITabBarController

//添加一个界面, 类名, 标题, 图片
-(UIViewController *)addViewControllerWithName:(NSString *)name title:(NSString *)title image:(NSString *)image;


@end
