//
//  ZJHttpRequest.m
//  QFSNSUserListDemo
//
//  Created by mac on 14-11-24.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "ZJHttpRequest.h"

#import "ZJDataCache.h"

@interface ZJHttpRequest ()<NSURLConnectionDataDelegate>
{
    //为了存储init中传入block
    void (^_success)(NSData *data);
    
    //为了下载
    NSMutableData *_data;
    NSURLConnection *_urlConnection;
}
@end

@implementation ZJHttpRequest
//初始化方法
-(id)initWithURLString:(NSString *)urlString
               success:( void (^)(NSData *data) )success
{
    if(self = [super init])
    {
        //保存参数
        _urlString = urlString;
        _success = success;
        
        //缓存1. 判断数据是否下载过
        //  如果下载过, 不下载了, 从缓存中读取数据
        NSData *data = [[ZJDataCache sharedInstance] readDataFromUrlString:_urlString];
        //说明读取到了数据
        if(data != nil)
        {
            if(_success)
            {
                _success(data);
            }
            NSLog(@"从缓存中读取");
        }
        else
        {
            NSLog(@"从网络上下载");
            //开始下载数据, 利用NSURLConnection
            _data = [[NSMutableData alloc] init];
            _urlConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]] delegate:self startImmediately:YES];
        }
    }
    return self;
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //缓存2: 判断文件是否被保存到缓存中了
    //  如果没有保存, 保存到缓存中
    [[ZJDataCache sharedInstance] savaData:_data urlString:_urlString];
    
    
    //下载完成之后回调block
    if(_success)
    {
        _success(_data);
    }
}
@end
