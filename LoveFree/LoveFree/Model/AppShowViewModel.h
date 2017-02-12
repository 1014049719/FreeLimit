//
//  AppShowViewModel.h
//  LoveFree
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppShowViewModel : NSObject

@property (nonatomic, strong) NSString * applicationId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * iconUrl;
@property (nonatomic, strong) NSString * starOverall;
@property (nonatomic, strong) NSString * ratingOverall;
@property (nonatomic, strong) NSString * downloads;
@property (nonatomic, strong) NSString * comment;

@end
