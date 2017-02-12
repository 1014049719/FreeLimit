//
//  DetailViewController.h
//  FreeLimit1409
//
//  Created by mac on 14-11-28.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "RootViewController.h"

#import "AppModel.h"

@interface DetailViewController : RootViewController
//正向传值
@property (strong,nonatomic) AppModel *model;
@end
