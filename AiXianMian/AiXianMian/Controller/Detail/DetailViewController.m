//
//  DetailViewController.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import "FFModel.h"
#import "FFDetailModel.h"
#import "FFDetailView.h"
#import "ShowPhotosViewController.h"
#import "FMDatabase.h"
#import "FFArroundModel.h"

@interface DetailViewController ()<UMSocialUIDelegate>
{
    FFDetailModel * _model;
    NSMutableArray * _muArrArround;
    FFDetailView * _detailView;
    FMDatabase * _database;
}
@end

@implementation DetailViewController

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
    
    _model = [[FFDetailModel alloc] init];
    _muArrArround = [[NSMutableArray alloc] init];
    
    [self loadData];
    
    _detailView = [[FFDetailView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:_detailView];
    
}

-(void)loadData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    //NSLog(@"%@",_applicationId);
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:DETAIL_URL,_applicationId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError * error;
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
        //NSLog(@"%@",dic);
        
        _model.iconUrl = [dic objectForKey:@"iconUrl"];
        
        _model.name = [dic objectForKey:@"name"];
        
        _model.lastPrice = [dic objectForKey:@"lastPrice"];
        
        //NSLog(@"%@",_model.lastPrice);
        
        _model.starCurrent = [dic objectForKey:@"starCurrent"];
        
        _model.fileSize = [dic objectForKey:@"fileSize"];
        
        _model.categoryName = [dic objectForKey:@"categoryName"];
        
        _model.photos = [dic objectForKey:@"photos"];
        
        _model.description = [dic objectForKey:@"description"];
        
        _model.itunesUrl = [dic objectForKey:@"itunesUrl"];
        
        [self showView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    AFHTTPRequestOperationManager * manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager1 GET:[NSString stringWithFormat:NEARBY_APP_URL,113.2007,23.1024] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * arr = [dic objectForKey: @"applications"];
        
        for (NSDictionary * dic1 in arr)
        {
            FFArroundModel * arroundModel = [[FFArroundModel alloc] init];
            arroundModel.applicationId = [dic1 objectForKey:@"applicationId"];
            arroundModel.name = [dic1 objectForKey:@"name"];
            arroundModel.iconUrl = [dic1 objectForKey:@"iconUrl"];
            [_muArrArround addObject: arroundModel];
        }
        
        [self showView2];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

//显示详情
-(void)showView
{
    
    [_detailView.imageViewIcon setImageWithURL:[NSURL URLWithString:_model.iconUrl]];
    
    _detailView.labelName.text = _model.name;
    
    _detailView.labelLastPrice.text = [NSString stringWithFormat:@"原价$%.2f",[_model.lastPrice floatValue]];
    
    _detailView.labelCategoryName.text = [NSString stringWithFormat:@"类型: %@",_model.categoryName];
    
    _detailView.labelFileSize.text = [NSString stringWithFormat:@"%@MB",_model.fileSize];
    
    _detailView.labelstarCurrent.text = [NSString stringWithFormat:@"评分: %@",_model.starCurrent];
    
    int x = 5;
    
    for (int i = 0; i < _model.photos.count; i ++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, 0, 88, 88);
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(gotoShow:) forControlEvents:UIControlEventTouchUpInside];
        [_detailView.scrollViewPhotos addSubview:btn];
        
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
        NSDictionary * dic = _model.photos[i];
        [imageView1 setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"smallUrl"]]];
        [btn addSubview:imageView1];
        x += 100;
    }
    
    _detailView.scrollViewPhotos.contentSize = CGSizeMake(x, 0);
    
    _detailView.labelDescription.text = _model.description;
    
    [_detailView.btnShare addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_detailView.btnFavorites addTarget:self action:@selector(favoritesClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if([self isFavorite])
    {
        _detailView.btnFavorites.enabled = NO;
        [_detailView.btnFavorites setTitle:@"已收藏" forState:UIControlStateNormal];
        [_detailView.btnFavorites setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    [_detailView.btnDownload addTarget:self action:@selector(downloadClick:) forControlEvents:UIControlEventTouchUpInside];
}

//显示附近的人在用
-(void)showView2
{
    int x1 = 10;
    int y1 = 0;
    int w1 = 45;
    int h1 = 60;
    
    for (int i = 0; i < _muArrArround.count; i ++)
    {
        FFArroundModel * model = _muArrArround[i];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(x1, y1, w1, h1)];
        [_detailView.scrollViewArround addSubview:view];
        
        UIButton * btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
        btnImage.frame = CGRectMake(0, 15, 45, 45);
        [btnImage addTarget:self action:@selector(arroundClick:) forControlEvents:UIControlEventTouchUpInside];
        btnImage.tag = 100 + i;
        [view addSubview:btnImage];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        [imageView setImageWithURL:[NSURL URLWithString:model.iconUrl]];
        [btnImage addSubview:imageView];
        
        UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 63, 45, 12)];
        labelTitle.text = model.name;
        labelTitle.font = [UIFont systemFontOfSize:12];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        [view addSubview:labelTitle];
        
        x1 += w1 + 10;
    }
    _detailView.scrollViewArround.contentSize = CGSizeMake(56*_muArrArround.count, 0);

}


-(void)arroundClick:(UIButton *)btn
{
    DetailViewController * dvc = [[DetailViewController alloc] init];
    dvc.navigationItem.title = @"应用详情";
    dvc.applicationId = ((FFArroundModel *)_muArrArround[btn.tag - 100]).applicationId;
    [self.navigationController pushViewController:dvc animated:YES];
}

-(void)gotoShow:(UIButton *)btn
{
    ShowPhotosViewController * spvc = [[ShowPhotosViewController alloc] init];
    spvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    spvc.photos = _model.photos;
    spvc.index = btn.tag - 100;
    [self presentViewController:spvc animated:YES completion:nil];
}

-(void)shareClick:(UIButton *)btn
{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,nil]
                                       delegate:self];
}

-(void)favoritesClick:(UIButton *)btn
{
    if([self openDatabase] && [self createTable])
    {
       if([self addFavorites])
       {
           [btn setTitle:@"已收藏" forState:UIControlStateNormal];
           [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
           btn.enabled = NO;
       }
    }
}

-(BOOL)isFavorite
{
    [self openDatabase];
    NSString * sql = @"select * from Favorites where applicationId = ?";
    if([[_database executeQuery:sql,_applicationId] next])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)downloadClick:(UIButton *)btn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.itunesUrl]];
}

-(BOOL)openDatabase
{
     NSString * path = [NSString stringWithFormat:@"%@/Documents/Favorites1.rdb",NSHomeDirectory()];
    _database = [[FMDatabase alloc] initWithPath:path];
    if(_database.open)
    {
        NSLog(@"数据库打开成功");
    }
    else
    {
        NSLog(@"数据库打开失败");
    }
    return _database.open;
}

-(BOOL)createTable
{
    NSString * sql = @"create table if not exists Favorites (applicationId Varchar(32) primary key, applicationName Varchar(50), iconUrl Varchar(100));";
    BOOL result = [_database executeUpdate:sql];
    if(result)
    {
        NSLog(@"表创建成功");
    }
    else
    {
        NSLog(@"表创建失败");
    }
    return result;
}

-(BOOL)addFavorites
{
    NSString * sql = @"insert into Favorites (applicationId, applicationName, iconUrl) values (?, ?, ?);";
    BOOL result = [_database executeUpdate:sql,_applicationId,_model.name,_model.iconUrl];
    NSLog(@"%@",_applicationId);
    if(result)
    {
        NSLog(@"收藏成功");
    }
    else
    {
        NSLog(@"添加收藏失败");
    }
    return result;
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
