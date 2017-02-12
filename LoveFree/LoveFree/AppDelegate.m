//
//  AppDelegate.m
//  LoveFree
//
//  Created by qianfeng on 14-12-26.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import "AppDelegate.h"
#import "FreePageViewController.h"
#import "HotListPageViewController.h"
#import "LimitFreePageViewController.h"
#import "SalePageViewController.h"
#import "TopicPageViewController.h"
#import "UMSocial.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [UMSocialData setAppKey: @"54a29e5bfd98c53a2e000642"];
    LimitFreePageViewController * limitFreePageVC = [[LimitFreePageViewController alloc] init];
    limitFreePageVC.title = @"限免";
    limitFreePageVC.tabBarItem.image = [UIImage imageNamed: @"tabbar_limitfree.png"];
    UINavigationController * limitFreePageNC = [[UINavigationController alloc] initWithRootViewController: limitFreePageVC];
    
    SalePageViewController * salePageVC = [[SalePageViewController alloc] init];
    salePageVC.title = @"降价";
    salePageVC.tabBarItem.image = [UIImage imageNamed: @"tabbar_reduceprice.png"];
    UINavigationController * salePageNC = [[UINavigationController alloc] initWithRootViewController: salePageVC];
    
    FreePageViewController * freePageVC = [[FreePageViewController alloc] init];
    freePageVC.title = @"免费";
    freePageVC.tabBarItem.image = [UIImage imageNamed: @"tabbar_appfree.png"];
    UINavigationController * freePageNC = [[UINavigationController alloc] initWithRootViewController: freePageVC];
    
    TopicPageViewController * topicPageVC = [[TopicPageViewController alloc] init];
    topicPageVC.title = @"专题";
    topicPageVC.tabBarItem.image = [UIImage imageNamed: @"tabbar_subject.png"];
    UINavigationController * topicPageNC = [[UINavigationController alloc] initWithRootViewController: topicPageVC];
    
    HotListPageViewController * hotListPageVC = [[HotListPageViewController alloc] init];
    hotListPageVC.title = @"热榜";
    hotListPageVC.tabBarItem.image = [UIImage imageNamed: @"tabbar_rank.png"];
    UINavigationController * hotListPageNC = [[UINavigationController alloc] initWithRootViewController: hotListPageVC];
    
    UITabBarController * loveFreeTBC = [[UITabBarController alloc] init];
    loveFreeTBC.viewControllers = @[limitFreePageNC, salePageNC, freePageNC, topicPageNC, hotListPageNC];
    
    self.window.rootViewController = loveFreeTBC;
    
    UIImageView * startView = [[UIImageView alloc] initWithFrame: self.window.bounds];
    startView.image = [UIImage imageNamed: @"Default@2x"];
    [loveFreeTBC.view addSubview: startView];
    
    [UIView beginAnimations: @"" context: nil];
    [UIView setAnimationDuration: 3];
    startView.alpha = 0;
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
