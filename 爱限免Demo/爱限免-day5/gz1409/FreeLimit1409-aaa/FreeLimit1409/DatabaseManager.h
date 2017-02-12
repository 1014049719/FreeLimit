//
//  DatabaseManager.h
//  FreeLimit1409
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppModel.h"

//功能: 封装所有关于数据库的操作
//  初始化: 床架数据库, 创建表格
//  保存信息(收藏信息, 关注信息, 下载信息)
//  读取信息(收藏信息, 关注信息, 下载信息)

typedef enum RecordType
{
    RecordTypeFavorite,
    RecordTypeDownload,
    RecordTypeAttention
}RecordType;


@interface DatabaseManager : NSObject

//需要在多个界面同时操作数据库,设计成单例
//  完成初始化操作
+(id)sharedInstance;

//添加一条记录, 第二个参数是记录类型
-(void)addRecordWithAppModel:(AppModel *)model recordType:(RecordType)recordType;

//判断有没有某个应用某种类型的记录
-(BOOL)isExistRecordWithAppModel:(AppModel *)model recordType:(RecordType)recordType;

//删除一条记录, 第二个参数是记录类型
-(void)removeRecordWithAppModel:(AppModel *)model recordType:(RecordType)recordType;

//获取某种类型的应用
-(NSArray *)recordsWithRecordType:(RecordType)recordType;

@end




