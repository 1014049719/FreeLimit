//
//  AppListViewController.h
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "RootViewController.h"

//界面的类型
typedef enum : NSUInteger {
    LIMTI,
    SALE,
    FREE,
    TOPIC,
    HOT
} AppListType;

@interface AppListViewController : RootViewController
//传入一个接口, 每个界面接口是不一样的
@property (copy,nonatomic) NSString *urlString;
//传入界面的类型(限免,降价,免费,热榜)
@property (nonatomic) AppListType type;
@end
