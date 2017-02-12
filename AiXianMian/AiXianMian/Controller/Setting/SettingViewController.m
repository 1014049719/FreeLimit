//
//  SettingViewController.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-26.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "SettingViewController.h"
#import "FavoritesViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray * arrImageName = @[@"account_setting.png", @"account_favorite.png",@"account_user.png",@"account_collect.png",@"account_download.png",@"account_comment.png",@"account_help.png",@"account_candou.png",];
    NSArray * arrTitle = @[@"我的设置",@"我的关注",@"我的账户",@"我的收藏",@"我的下载",@"我的评论",@"我的帮助",@"蚕豆应用"];
    
    int x = 35;
    int y = 35;
    int w = 57;
    int h = 77;
    int intervalW = 40;
    int intervalH = 25;
    
    for(int i = 0; i < 8; i ++)
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [self.view addSubview:view];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(0, 0, 57, 57);
        
        btn.tag = 1000 + i;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:arrImageName[i]] forState:UIControlStateNormal];
        
        [view addSubview: btn];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 67, 57, 12)];
        
        label.text = arrTitle[i];
        
        label.font = [UIFont systemFontOfSize:12];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [view addSubview: label];
        
        x += w + intervalW;
        
        if((i + 1) % 3 == 0)
        {
            y += h + intervalH;
            x = 35;
        }
    }
}

-(void)btnClick:(UIButton *)btn
{
    if(btn.tag == 1003)
    {
        FavoritesViewController * fvc = [[FavoritesViewController alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
    }
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
