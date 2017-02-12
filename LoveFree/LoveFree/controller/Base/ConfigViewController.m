//
//  ConfigViewController.m
//  LoveFree
//
//  Created by qianfeng on 15-1-4.
//  Copyright (c) 2015年 syc. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

@end

@implementation ConfigViewController

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
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"设置详情";
    [self creatUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 配置页面视图创建

- (void)creatUI
{
    self.view.backgroundColor = [UIColor colorWithRed: 226 / 255.0 green: 226 / 255.0 blue: 226 / 255.0 alpha: 1];
    NSArray * btnImageNameArray = @[@"account_setting", @"account_favorite", @"account_user", @"account_collect", @"account_download", @"account_comment", @"account_help", @"account_candou"];
    NSArray * labelTextArray = @[@"我的设置", @"我的关注", @"我的账户", @"我的收藏", @"我的下载", @"我的评论", @"我的帮助", @"蚕豆应用"];
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (i + j != 4) {
                UIButton * btn = [[UIButton alloc] initWithFrame: CGRectMake(30 + j * (60 + 30), 40 + i * (60 + 40), 60, 60)];
                [btn setBackgroundImage: [UIImage imageNamed: btnImageNameArray[i * 3 + j]] forState: UIControlStateNormal];
                [btn.layer setCornerRadius: 5];
                [btn.layer setMasksToBounds: YES];
                [self.view addSubview: btn];
                UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake(30 + j * (60 + 30), 110 + i * (60 + 40), 60, 20)];
                label.font = [UIFont systemFontOfSize: 12];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = labelTextArray[i * 3 + j];
                [self.view addSubview: label];
            }
        }
    }
}

#pragma mark -

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
