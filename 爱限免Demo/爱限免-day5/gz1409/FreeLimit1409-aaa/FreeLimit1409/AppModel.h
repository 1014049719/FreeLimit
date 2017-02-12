//
//  AppModel.h
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject
@property (copy,nonatomic) NSString *priceTrend;
@property (copy,nonatomic) NSString *expireDatetime;
@property (copy,nonatomic) NSString *fileSize;
@property (copy,nonatomic) NSString *categoryName;
@property (copy,nonatomic) NSString *ipa;
@property (copy,nonatomic) NSString *itunesUrl;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *version;
@property (copy,nonatomic) NSString *currentPrice;
@property (copy,nonatomic) NSString *starCurrent;
@property (copy,nonatomic) NSString *starOverall;
@property (copy,nonatomic) NSString *favorites;
@property (copy,nonatomic) NSString *iconUrl;
@property (copy,nonatomic) NSString *releaseNotes;
@property (copy,nonatomic) NSString *releaseDate;
@property (copy,nonatomic) NSString *updateDate;
@property (copy,nonatomic) NSString *slug;
@property (copy,nonatomic) NSString *downloads;
@property (copy,nonatomic) NSString *lastPrice;
@property (copy,nonatomic) NSString *ratingOverall;
@property (copy,nonatomic) NSString *applicationId;
@property (copy,nonatomic) NSString *description;
@property (copy,nonatomic) NSString *categoryId;
@property (copy,nonatomic) NSString *shares;

//详情界面, 添加截图信息
@property (copy,nonatomic) NSArray *photos;

//专题界面使用的
@property (copy,nonatomic) NSNumber *comment;
@end
