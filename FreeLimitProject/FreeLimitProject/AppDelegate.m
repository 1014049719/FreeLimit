//
//  AppDelegate.m
//  FreeLimitProject
//
//  Created by 胡贝 on 14/12/23.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import "AppDelegate.h"
#import "FreeViewController.h"
#import "HotViewController.h"
#import "LimitViewController.h"
#import "SaleViewController.h"
#import "TopicViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    LimitViewController *limitVC = [[LimitViewController alloc] init];
    limitVC.title = @"限免";
    limitVC.tabBarItem.image=[UIImage imageNamed:@"tabbar_limitfree.png"];
    limitVC.urlString = LIMIT_URL;
    UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:limitVC];
    
    SaleViewController *saleVC = [[SaleViewController alloc] init];
    saleVC.title = @"降价";
    saleVC.tabBarItem.image=[UIImage imageNamed:@"tabbar_reduceprice.png"];
    saleVC.urlString = SALE_URL;
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:saleVC];
    
    FreeViewController *freeVC = [[FreeViewController alloc] init];
    freeVC.title = @"免费";
    freeVC.tabBarItem.image=[UIImage imageNamed:@"tabbar_appfree.png"];
    freeVC.urlString = FREE_URL;
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:freeVC];
    
    TopicViewController *topicVC = [[TopicViewController alloc] init];
    topicVC.title = @"专题";
    topicVC.tabBarItem.image=[UIImage imageNamed:@"tabbar_subject.png"];
    topicVC.urlString=TOPIC_URL;
    UINavigationController *nv4 = [[UINavigationController alloc] initWithRootViewController:topicVC];
    
    HotViewController *hotVC = [[HotViewController alloc] init];
    hotVC.title = @"热榜";
    hotVC.tabBarItem.image=[UIImage imageNamed:@"tabbar_rank.png"];
    hotVC.urlString = HOT_URL;
    UINavigationController *nv5 = [[UINavigationController alloc] initWithRootViewController:hotVC];
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    [tbc.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
    tbc.viewControllers = @[nv1,nv2,nv3,nv4,nv5];
    
    self.window.rootViewController = tbc;
    
    //启动界面
    UIImageView *startview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    startview.image=[UIImage imageNamed:@"Default1"];
    [tbc.view addSubview:startview];
    //逐渐消失
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:3];
    startview.alpha=0;
    [UIView commitAnimations];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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
