//
//  AppDelegate.m
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "AppDelegate.h"

#import "MyTabBarController.h"

#import "AppListViewController.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "TencentOpenAPI/TencentOAuth.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    [self configUMShare];
    
    [self createTabBar];
    
    //应用图标上显示的数字
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:10];;
    
    
    return YES;
}

-(void)configUMShare
{
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    //设置微信AppId，url地址传nil，将默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:nil];
    //设置手机QQ的AppId，url传nil，将使用友盟的网址
    [UMSocialConfig setQQAppId:@"100424468" url:nil importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
}

-(void)createTabBar
{
    //添加标签栏
    MyTabBarController *mtbc = [[MyTabBarController alloc] init];
    AppListViewController *vc = (AppListViewController *)[mtbc addViewControllerWithName:@"LimitViewController" title:@"限免" image:@"tabbar_limitfree.png"];
    vc.urlString = LIMIT_URL;
    vc.type = LIMTI;
    
    vc = (AppListViewController *)[mtbc addViewControllerWithName:@"SaleViewController" title:@"降价" image:@"tabbar_reduceprice.png"];
    vc.urlString = SALE_URL;
    vc.type = SALE;
    
    vc = (AppListViewController *)[mtbc addViewControllerWithName:@"FreeViewController" title:@"免费" image:@"tabbar_appfree.png"];
    vc.urlString = FREE_URL;
    vc.type = FREE;
    
    [mtbc addViewControllerWithName:@"TopicViewController" title:@"专题" image:@"tabbar_subject.png"];
    
    vc = (AppListViewController *)[mtbc addViewControllerWithName:@"HotViewController" title:@"热榜" image:@"tabbar_rank.png"];
    vc.urlString = HOT_URL;
    vc.type = HOT;
    
    self.window.rootViewController = mtbc;
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置标签栏背景
    [mtbc.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
    
    //添加启动图片
    UIImageView *statView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    statView.image = [UIImage imageNamed:@"Default1.png"];
    [mtbc.view addSubview:statView];
    [UIView animateWithDuration:2 animations:^{
        statView.alpha = 0;
    } completion:^(BOOL finished) {
        [statView removeFromSuperview];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
