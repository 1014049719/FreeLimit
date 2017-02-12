//
//  SettingViewController.m
//  FreeLimitProject1422
//
//  Created by mac on 14-9-11.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "SettingViewController.h"

#import "MyFavoriteViewController.h"


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
	// Do any additional setup after loading the view.
    
    //
    self.title = @"配置";
    
    //
    [self createUI];
    
}

-(void)createUI
{
    self.view.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
    
    //创建8个按钮
    NSArray *imageArray = @[@"setting",@"favorite",@"user",@"collect",@"download",@"comment",@"help",@"candou"];
    NSArray *titleArray = @[@"我的设置",@"我的关注",@"我的账户",@"我的收藏",@"我的下载",@"我的评论",@"我的帮助",@"蚕豆应用"];
    int count = imageArray.count;
    for (int i=0; i<count; i++) {
        //UIButton *button = [UIButton imageButtonWithFrame:CGRectMake(35+i%3*(57+35), 64+40+i/3*(57+35), 57, 57) title:nil image:[NSString stringWithFormat:@"account_%@",imageArray[i]] background:  action:@selector(btnClick:)];
        UIButton *button = [UIButton imageButtonWithFrame:CGRectMake(35+i%3*(57+35), 40+i/3*(57+35), 57, 57) title:nil image:[NSString stringWithFormat:@"account_%@",imageArray[i]] action:^(UIButton *button) {
            
            if(button.tag == 103)
            {
                MyFavoriteViewController *mfvc = [[MyFavoriteViewController alloc] init];
                [self.navigationController pushViewController:mfvc animated:YES];
            }
            
        }];
        button.tag = 100 + i;
        [self.view addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35+i%3*(57+35), 40+i/3*(57+35) + 45, 100, 57)];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:label];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
