//
//  ZJDataCache.h
//  FreeLimit1409
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <Foundation/Foundation.h>

//什么是缓存, 缓存的功能

//需求: 移动设备网速较慢(2G), 网络流量是收费的
//考虑如何提高下载速度, 如何节省流量?

//解决: 使用缓存功能

//效果: 如果数据以前没有下载过, 从网络中下载数据
//如果数据已经下载过, 直接从缓存中读取数据

@interface ZJDataCache : NSObject

//1.获取单例
+(id)sharedInstance;

//2.保存数据到缓存中
-(void)savaData:(NSData *)data urlString:(NSString *)urlstring;

//3.从缓存中读取数据
-(NSData *)readDataFromUrlString:(NSString *)urlstring;

//其他功能
//设置缓存文件有效时间
@property (nonatomic) NSTimeInterval validateTime;

//计算缓存大小
//返回字节数
-(int)cacheFileSize;

//清空缓存
-(void)clearCache;

@end
