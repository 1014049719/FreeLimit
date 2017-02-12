//
//  HTTPrequest.m
//  下载库封装
//
//  Created by qianfeng on 14-12-22.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "HTTPrequest.h"

@implementation HTTPrequest

-(id)initWithurlstring:(NSString *)urlstring target:(id)target action:(SEL)action{

    self = [super init];
    if (self) {
        
        self.downloaddata=[[NSMutableData alloc] init];
        _target=target;
        _action=action;
        NSURL *url=[[NSURL alloc] initWithString:urlstring];
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
        connection=[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    }
    return self;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    NSLog(@"服务器响应");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    NSLog(@"接收数据");
    [self.downloaddata appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

    NSLog(@"加载完成");
    [_target performSelector:_action withObject:self];

}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    NSLog(@"加载出错");

}

@end
