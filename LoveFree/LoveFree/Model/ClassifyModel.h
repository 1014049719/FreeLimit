//
//  ClassifyModel.h
//  LoveFree
//
//  Created by qianfeng on 14-12-31.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifyModel : NSObject

@property (nonatomic, strong) NSString * category_id;
@property (nonatomic, strong) NSString * category_count;
@property (nonatomic, strong) NSString * category_name;
@property (nonatomic, strong) NSString * category_cname;
@property (nonatomic, strong) NSMutableDictionary * priceTrendDic;


@end