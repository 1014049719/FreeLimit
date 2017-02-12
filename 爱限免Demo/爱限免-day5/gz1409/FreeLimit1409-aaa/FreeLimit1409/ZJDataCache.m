//
//  ZJDataCache.m
//  FreeLimit1409
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "ZJDataCache.h"

#import "NSString+Hashing.h"

#define DataCacheDirectory [NSString stringWithFormat:@"%@/Documents/ZJDataCache",NSHomeDirectory()]

//30分钟
#define DefaultValidateTime 30*60

@implementation ZJDataCache

//1.获取单例
+(id)sharedInstance
{
    static ZJDataCache *dc = nil;
    if(dc == nil)
    {
        dc = [[[self class] alloc] init];
    }
    return dc;
}

//初始化方法
//1. 创建缓存文件夹
-(id)init
{
    if(self = [super init])
    {
        //创建缓存目录
        NSString *path = DataCacheDirectory;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
        _validateTime = DefaultValidateTime;
        
    }
    return self;
}

//2.保存数据到缓存中
-(void)savaData:(NSData *)data urlString:(NSString *)urlstring
{
    //data 保存的数据
    //urlString 数据对应的网址
    
    //问题: 数据的文件名是啥?
    
    //解决: 先把网址转化为MD5编码
    //  MD5编码
    //  MD5算法对原信息进行数学变换后得到的一个128位(bit)的特征码
    //  任意信息之间具有相同MD5码的可能性非常之低，通常被认为是不可能的。
    
    //1.获取文件路径
    NSString *path = [NSString stringWithFormat:@"%@/%@",DataCacheDirectory,[urlstring MD5Hash]];
    //2.保存到缓存中
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        return;
    }
    [data writeToFile:path atomically:YES];
}
//3.从缓存中读取数据
//返回值: 如果读取到数据,返回有效指针
//      否则返回nil
-(NSData *)readDataFromUrlString:(NSString *)urlstring
{
    //1.获取文件路径
    NSString *path = [NSString stringWithFormat:@"%@/%@",DataCacheDirectory,[urlstring MD5Hash]];
    
    //代码没写完....
    //判断数据有没有过期
    //如果数据过期, 直接返回
    //获取文件时间, 获取当前时间
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    //获取当前时间, 和文件最后修改时间的间隔
    double interval = [[NSDate date] timeIntervalSinceDate:dict[NSFileModificationDate]];
    
    //获取文件大小
    // dict[NSFileSize];    //注意类型 NSNumber
    
    //NSLog(@"interval = %f",interval / 60.0);
    //NSLog(@"_validateTime = %f",_validateTime);
    if(interval > _validateTime)
    {
        return nil;
    }

    
    //2.返回文件
    return [[NSData alloc] initWithContentsOfFile:path];
}

//计算缓存大小
//返回字节数
-(int)cacheFileSize;
{
    //思路: 遍历DataCacheDirectory中文件
    //      获取每个文件的大小, 计算总和
    //      返回大小
    return 0;
}

//清空缓存
-(void)clearCache;
{
    //清空缓存
    //思路: 删除DataCacheDirectory中所有文件
}


@end
