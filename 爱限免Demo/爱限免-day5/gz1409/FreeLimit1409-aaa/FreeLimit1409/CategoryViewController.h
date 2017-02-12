//
//  CategoryViewController.h
//  FreeLimit1409
//
//  Created by mac on 14-11-28.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "RootViewController.h"

@interface CategoryViewController : RootViewController
-(void)setChangeCategoryAction:( void(^) (NSString *categoryID) )action;
@end
