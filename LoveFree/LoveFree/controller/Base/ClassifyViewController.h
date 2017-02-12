//
//  ClassifyViewController.h
//  LoveFree
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassifyShowProtocol <NSObject>

- (void)setCategoryId:(NSString *)categoryId;

@end

@interface ClassifyViewController : UIViewController

@property (nonatomic, strong) NSString * category_id;
@property (nonatomic, strong) NSString * priceTrend;
@property (nonatomic, weak) id <ClassifyShowProtocol> delegate;

@end
