//
//  HTTPrequest.h
//  下载库封装
//
//  Created by qianfeng on 14-12-22.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPrequest : NSObject<NSURLConnectionDataDelegate>
{
    NSURLConnection *connection;
    
    id _target;
    SEL _action;
}
//接收数据的属性
@property (strong,nonatomic)NSMutableData *downloaddata;
//初始化方法
-(id)initWithurlstring:(NSString *)urlstring target:(id)target action:(SEL)action;

@end
