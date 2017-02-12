//
//  Topicmodel.h
//  FreeLimitProject
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topicmodel : NSObject

@property (strong,nonatomic)NSString *title;
@property (strong,nonatomic)NSString *img;
@property (strong,nonatomic)NSString *desc;
@property (strong,nonatomic)NSString *desc_img;
@property (strong,nonatomic)NSString *date;
@property (nonatomic, strong) NSArray * applications;

@property (nonatomic, strong) NSString * applicationId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * iconUrl;
@property (nonatomic, strong) NSString * starOverall;
@property (nonatomic, strong) NSString * ratingOverall;
@property (nonatomic, strong) NSString * downloads;
@property (nonatomic, strong) NSString * comment;


@end
