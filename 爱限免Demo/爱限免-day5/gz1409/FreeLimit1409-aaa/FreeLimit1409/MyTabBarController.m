//
//  MyTabBarController.m
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//添加一个界面, 类名, 标题, 图片
//
-(UIViewController *)addViewControllerWithName:(NSString *)name title:(NSString *)title image:(NSString *)image;
{
    //参数1: 传入的是界面类名 @"LimitViewController"
    //  转化为类
    Class cls = NSClassFromString(name);
    UIViewController *vc = [[cls alloc] init];
    vc.title = title;

    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.tabBarItem.image = [UIImage imageNamed:image];
    
    //视图控制器加到到tabBar中
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    [array addObject:nc];
    self.viewControllers = array;
    
    return vc;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//UIViewController的方法
//设置能否旋转
-(BOOL)shouldAutorotate
{
    return YES;
}

//设置支持的方向
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

//控制能否旋转到某个方向
//  参数是将要旋转到的方向, 返回是否能旋转到这个方向

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

//处理旋转
//即将旋转
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"即将旋转");
}
//即将结束旋转
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"旋转结束");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
