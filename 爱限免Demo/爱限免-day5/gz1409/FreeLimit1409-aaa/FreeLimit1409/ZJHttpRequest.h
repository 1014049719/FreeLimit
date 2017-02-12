//
//  ZJHttpRequest.h
//  QFSNSUserListDemo
//
//  Created by mac on 14-11-24.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import <Foundation/Foundation.h>

//功能: 下载网络数据

@interface ZJHttpRequest : NSObject
//设置下载地址
@property (copy,nonatomic) NSString *urlString;

//初始化方法
//参数2: 下载执行执行的block
//  void success(NSData *data)
//  void (^success)(NSData *data)
-(id)initWithURLString:(NSString *)urlString
               success:( void (^)(NSData *data) )success;
@end



