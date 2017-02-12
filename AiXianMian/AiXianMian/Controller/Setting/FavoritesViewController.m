//
//  FavoritesViewController.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-31.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()
{
    FMDatabase * _database;
    NSMutableArray * _muArrApplicationId;
    UIScrollView * _scollView;
}

@end

@implementation FavoritesViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"我的收藏";
    
    _scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64-49)];
    [self.view addSubview:_scollView];
    [self showView];
    
}

-(FMResultSet *)selectFavorites
{
    NSString * sql = @"select * from Favorites";
    NSString * path = [NSString stringWithFormat:@"%@/Documents/Favorites1.rdb",NSHomeDirectory()];
    _database = [[FMDatabase alloc] initWithPath:path];
    
    FMResultSet * resultSet;
    if(_database.open)
    {
        resultSet = [_database executeQuery:sql];
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
    return resultSet;
}

-(void)showView
{
    int x = 35;
    int y = 35;
    int w = 57;
    int h = 77;
    int intervalW = 40;
    int intervalH = 25;
    int i = 0;
    
    _muArrApplicationId = [[NSMutableArray alloc] init];
    
    FMResultSet * resultSet = [self selectFavorites];
    
    while ([resultSet next])
    {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_scollView addSubview:view];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100 + i;
        btn.frame = CGRectMake(0, 0, 57, 57);
        [btn addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 57, 57)];
        [imageView setImageWithURL:[NSURL URLWithString:[resultSet stringForColumn:@"iconUrl"]]];
        imageView.layer.cornerRadius = 10;
        imageView.clipsToBounds = YES;
        [btn addSubview:imageView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 67, 57, 12)];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [resultSet stringForColumn:@"applicationName"];
        [view addSubview:label];
        
        [_muArrApplicationId addObject:[resultSet stringForColumn:@"applicationId"]];
        
        x += w + intervalW;
        
        if((i + 1) % 3 == 0)
        {
            x = 35;
            y += h + intervalH;
        }

        i ++;
    }
    _scollView.contentSize = CGSizeMake(0, 77 * ((i + 1) / 3 + 1));
}

-(void)gotoDetail:(UIButton *)btn
{
    DetailViewController * dvc = [[DetailViewController alloc] init];
    dvc.applicationId = _muArrApplicationId[btn.tag - 100];
    [self.navigationController pushViewController:dvc animated:YES];
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
