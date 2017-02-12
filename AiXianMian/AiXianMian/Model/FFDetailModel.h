//
//  FFDetailModel.h
//  AiXianMian
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFDetailModel : NSObject

@property (nonatomic, strong) NSString * iconUrl;

@property (nonatomic, strong) NSString * name;

@property (nonatomic, strong) NSString * lastPrice;

@property (nonatomic, strong) NSString * starCurrent;

@property (nonatomic, strong) NSString * fileSize;

@property (nonatomic, strong) NSString * categoryName;

@property (nonatomic, strong) NSMutableArray * photos;

@property (nonatomic, strong) NSString * description;

@property (nonatomic, strong) NSString * itunesUrl;

@end
