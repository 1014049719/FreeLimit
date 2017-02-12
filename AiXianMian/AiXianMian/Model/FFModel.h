//
//  FFModel.h
//  AiXianMian
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFModel : NSObject

@property (nonatomic, strong) NSString * iconUrl;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * currentPrice;
@property (nonatomic, strong) NSString * lastPrice;
@property (nonatomic, strong) NSString * starCurrent;
@property (nonatomic, strong) NSString * categoryName;
@property (nonatomic, strong) NSString * shares;
@property (nonatomic, strong) NSString * favorites;
@property (nonatomic, strong) NSString * downloads;
@property (nonatomic, strong) NSString * applicationId;

@end
