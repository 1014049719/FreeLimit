//
//  AppDelegate.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-26.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "LimitViewController.h"
#import "ReducepriceViewController.h"
#import "FreeViewController.h"
#import "TopicViewController.h"
#import "HotViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    
    //限免
    LimitViewController * lvc = [[LimitViewController alloc] init];
    lvc.urlString = LIMIT_URL;
    lvc.pageName = @"lvc";
    UINavigationController * nc1 = [[UINavigationController alloc] initWithRootViewController:lvc];
    nc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_limitfree.png"];
    lvc.navigationItem.title = @"限免";
    nc1.tabBarItem.title = @"限免";
    [nc1.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //降价
    ReducepriceViewController * rvc = [[ReducepriceViewController alloc] init];
    rvc.urlString = SALE_URL;
    rvc.pageName = @"rvc";
    UINavigationController * nc2 = [[UINavigationController alloc] initWithRootViewController:rvc];
    nc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_reduceprice.png"];
    rvc.navigationItem.title = @"降价";
    nc2.tabBarItem.title = @"降价";
    [nc2.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //免费
    FreeViewController * fvc = [[FreeViewController alloc] init];
    fvc.urlString = FREE_URL;
    fvc.pageName = @"fvc";
    UINavigationController * nc3 = [[UINavigationController alloc] initWithRootViewController:fvc];
    nc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_appfree"];
    fvc.navigationItem.title = @"免费";
    nc3.tabBarItem.title = @"免费";
    [nc3.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //专题
    TopicViewController * tvc = [[TopicViewController alloc] init];
    UINavigationController * nc4 = [[UINavigationController alloc] initWithRootViewController:tvc];
    nc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_subject.png"];
    tvc.navigationItem.title = @"专题";
    nc4.tabBarItem.title = @"专题";
    [nc4.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //热榜
    HotViewController * hvc = [[HotViewController alloc] init];
    hvc.urlString = HOT_URL;
    hvc.pageName = @"hvc";
    UINavigationController * nc5 = [[UINavigationController alloc] initWithRootViewController:hvc];
    nc5.tabBarItem.image = [UIImage imageNamed:@"tabbar_rank"];
    hvc.navigationItem.title = @"热榜";
    nc5.tabBarItem.title = @"热榜";
    [nc5.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //tabBar
    UITabBarController * tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = @[nc1, nc2, nc3, nc4, nc5];
    tbc.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg.png"];
    
    //模拟启动画面 闪屏
    UIImageView *startView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    startView.image = [UIImage imageNamed:@"Default1.png"];
    [tbc.view addSubview:startView];
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:3.0];
    startView.alpha = 0;
    [UIView commitAnimations];
    
    
    self.window.rootViewController = tbc;
    
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
