//
//  DetailViewController.m
//  LoveFree
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import "DetailViewController.h"
#import "LoveFree-Prefix.pch"
#import "UMSocial.h"

@interface DetailViewController () <UMSocialUIDelegate>
{
    UIImageView * _iconImageView;
    UILabel * _nameLabel;
    UIScrollView * _detailScrollView;
    UILabel * _lastPriceLabel;
    UILabel * _priceTrendLabel;
    UILabel * _categoryNameLabel;
    UILabel * _starCurrentLabel;
    UILabel * _descriptionLabel;
    NSMutableArray * _photosArray;
    
    NSString * _itunesUrlString;
    
    UIImageView * _underImageView;
    
    FMDatabase * _collectDataBase;
    NSString * _applicationId;
    NSString * _name;
    NSString * _currentVersion;
    NSString * _updateDate;
    
    UIButton * _collectBtn;
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
    // Do any additional setup after loading the view.
    [self createUI];
    [self getDetailData];
    [self getNearbyData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI
{
    UIImageView * upImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10, 3, 300, 280)];
    upImageView.image = [UIImage imageNamed: @"appdetail_background"];
    upImageView.userInteractionEnabled = YES;
    [self.view addSubview: upImageView];
    
    _iconImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10, 10, 70, 70)];
    [_iconImageView.layer setCornerRadius: 10];
    [_iconImageView.layer setMasksToBounds: YES];
    [upImageView addSubview: _iconImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame: CGRectMake(90, 8, 300 - 100, 30)];
    [upImageView addSubview: _nameLabel];
    
    UIButton * shareBtn = [[UIButton alloc] initWithFrame: CGRectMake(1, 90, 99, 40)];
    [shareBtn setTitle: @"分享" forState: UIControlStateNormal];
    [shareBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    [shareBtn setBackgroundImage: [UIImage imageNamed: @"Detail_btn_left"] forState: UIControlStateNormal];
    [shareBtn addTarget: self action: @selector(shareBtnClick:) forControlEvents: UIControlEventTouchUpInside];
    [upImageView addSubview: shareBtn];
    
    _collectBtn = [[UIButton alloc] initWithFrame: CGRectMake(100, 90, 99, 40)];
    [_collectBtn setTitle: @"收藏" forState: UIControlStateNormal];
    [_collectBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    [_collectBtn setBackgroundImage: [UIImage imageNamed: @"Detail_btn_middle"] forState: UIControlStateNormal];
    [_collectBtn addTarget: self action: @selector(collectBtnClick:) forControlEvents: UIControlEventTouchUpInside];
    [upImageView addSubview: _collectBtn];
    
    UIButton * downloadBtn = [[UIButton alloc] initWithFrame: CGRectMake(199, 90, 99, 40)];
    [downloadBtn setTitle: @"下载" forState: UIControlStateNormal];
    [downloadBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    [downloadBtn setBackgroundImage: [UIImage imageNamed: @"Detail_btn_right"] forState: UIControlStateNormal];
    [downloadBtn addTarget: self action: @selector(downloadBtnClick:) forControlEvents: UIControlEventTouchUpInside];
    [upImageView addSubview: downloadBtn];
    
    _detailScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(10, 135, 280, 88)];
    _detailScrollView.showsHorizontalScrollIndicator = NO;
    _detailScrollView.showsVerticalScrollIndicator = NO;
    [upImageView addSubview: _detailScrollView];
    
    _lastPriceLabel = [[UILabel alloc] initWithFrame: CGRectMake(90, 38, 80, 20)];
    _lastPriceLabel.font = [UIFont systemFontOfSize: 12];
    _lastPriceLabel.text = @"原价: ";
    [upImageView addSubview: _lastPriceLabel];
    
    _priceTrendLabel = [[UILabel alloc] initWithFrame: CGRectMake(200, 38, 80, 20)];
    _priceTrendLabel.font = [UIFont systemFontOfSize: 12];
    _priceTrendLabel.text = self.navigationController.navigationItem.title;
    [upImageView addSubview: _priceTrendLabel];
    
    _categoryNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(90, 63, 100, 20)];
    _categoryNameLabel.font = [UIFont systemFontOfSize: 12];
    _categoryNameLabel.text = @"类型: ";
    [upImageView addSubview: _categoryNameLabel];
    
    _starCurrentLabel = [[UILabel alloc] initWithFrame: CGRectMake(200, 63, 80, 20)];
    _starCurrentLabel.font = [UIFont systemFontOfSize: 12];
    _starCurrentLabel.text = @"评分: ";
    [upImageView addSubview: _starCurrentLabel];
    
    _descriptionLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 230, 280, 40)];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont systemFontOfSize: 10];
    [upImageView addSubview: _descriptionLabel];
    
    _photosArray = [[NSMutableArray alloc] initWithCapacity: 0];
    
    _underImageView = [[UIImageView alloc] initWithFrame: CGRectMake(10, 282, 300, 90)];
    _underImageView.image = [UIImage imageNamed: @"appdetail_recommend"];
    [self.view addSubview: _underImageView];
}

#pragma mark -
#pragma mark 获取详情上半页面数据

- (void)getDetailData
{
    NSString * urlString = [NSString stringWithFormat: DETAIL_URL, [_appId intValue]];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET: urlString parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error;
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error: &error];
        
        _nameLabel.text = [dic objectForKey: @"name"];
        [_iconImageView setImageWithURL: [NSURL URLWithString: [dic objectForKey: @"iconUrl"]]];
        _lastPriceLabel.text = [NSString stringWithFormat: @"%@$%.2f", _lastPriceLabel.text, [[dic objectForKey: @"lastPrice"] floatValue]];
        _categoryNameLabel.text = [NSString stringWithFormat: @"%@%@", _categoryNameLabel.text, [dic objectForKey: @"categoryName"]];
        _starCurrentLabel.text = [NSString stringWithFormat: @"%@%@", _starCurrentLabel.text, [dic objectForKey: @"starCurrent"]];
        _descriptionLabel.text = [dic objectForKey: @"description"];
        _itunesUrlString = [dic objectForKey: @"itunesUrl"];
        
        _applicationId = [dic objectForKey: @"applicationId"];
        _name = [dic objectForKey: @"name"];
        _currentVersion = [dic objectForKey: @"currentVersion"];
        _updateDate = [dic objectForKey: @"updateDate"];
        [self isCollected];
        [_photosArray setArray: [dic objectForKey: @"photos"]];
        for (int i = 0; i < _photosArray.count; i++)
        {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame: CGRectMake((i + 1) * 5 + i * 155, 0, 155, 88)];
            [imageView setImageWithURL:[NSURL URLWithString: [_photosArray[i] objectForKey: @"smallUrl"]]];
            [_detailScrollView addSubview: imageView];
        }
        _detailScrollView.contentSize = CGSizeMake(_photosArray.count * 155, 0);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

#pragma mark -
#pragma mark 获取详情页面下半页面数据

- (void)getNearbyData
{
    NSString * urlString = @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=116.344539&latitude=40.034346";
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET: urlString parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error;
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error: &error];
        NSArray * arr = [dic objectForKey: @"applications"];
        for (int i = 0; i < arr.count; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame: CGRectMake(12 * (i + 1) + 45 * i, 20, 45, 45)];
            [imageView setImageWithURL: [NSURL URLWithString: [arr[i] objectForKey: @"iconUrl"]]];
            [imageView.layer setCornerRadius: 3];
            [imageView.layer setMasksToBounds: YES];
            [_underImageView addSubview: imageView];
            
            UILabel * nameLabel = [[UILabel alloc] initWithFrame: CGRectMake((i + 1) * 12 + i * 45, 65, 45, 20)];
            nameLabel.font = [UIFont systemFontOfSize: 10];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.text = [arr[i] objectForKey: @"name"];
            [_underImageView addSubview: nameLabel];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

#pragma mark -
#pragma mark 下载事件响应

- (void)downloadBtnClick:(UIButton *)btn
{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: _itunesUrlString]];
}

#pragma mark -
#pragma mark 收藏事件响应

- (void)collectBtnClick:(UIButton *)btn
{
//    NSString * path = [NSString stringWithFormat: @"%@/Documents/LoveFreeCollect.sqlite", NSHomeDirectory()];
//    NSLog(@"path = %@", path);
//    _collectDataBase = [[FMDatabase alloc] initWithPath: path];
//    
//    if (_collectDataBase.open == NO)
//    {
//        NSLog(@"数据库打开失败");
//    }
//    else
//    {
//        NSLog(@"数据库打开成功");
    NSString * sql = @"create table if not exists collect (applicationId Varchar(32), name Varchar(32), currentVersion Varchar(32), updateDate Varchar(32));";
    BOOL result = [_collectDataBase executeUpdate: sql];
    if (result == NO) {
        NSLog(@"创建或者打开表失败");
    }
    else
    {
        NSLog(@"表创建成功");
        NSString * sql = @"select * from collect where applicationId = ?;";
        FMResultSet * result = [_collectDataBase executeQuery: sql, _applicationId];
        if (![result next]) {
            NSLog(@"还没收藏");
            NSString * sql = @"insert into collect (applicationId, name, currentVersion, updateDate) values (?, ?, ?, ?);";
            BOOL result = [_collectDataBase executeUpdate: sql, _applicationId, _name, _currentVersion, _updateDate];
            if (result == NO) {
                NSLog(@"收藏失败");
            }
            else
            {
                NSLog(@"收藏成功");
                [_collectBtn setTitle: @"已收藏" forState: UIControlStateNormal];
                [_collectBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
            }
        }
        else
        {
            NSLog(@"已收藏");
        }
    }
}

#pragma mark -
#pragma mark 分享事件响应

- (void)shareBtnClick:(UIButton *)btn
{
    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}

#pragma mark -
#pragma mark 进入详情页面时候先判断该应用是否被收藏改变收藏按钮颜色

- (void)isCollected
{
    NSString * path = [NSString stringWithFormat: @"%@/Documents/LoveFreeCollect.sqlite", NSHomeDirectory()];
    NSLog(@"path = %@", path);
    _collectDataBase = [[FMDatabase alloc] initWithPath: path];
    
    if (_collectDataBase.open == NO)
    {
        NSLog(@"数据库打开失败");
    }
    else
    {
        NSLog(@"数据库打开成功");
        NSString * sql = @"create table if not exists collect (applicationId Varchar(32), name Varchar(32), currentVersion Varchar(32), updateDate Varchar(32));";
        BOOL result = [_collectDataBase executeUpdate: sql];
        if (result == NO)
        {
            NSLog(@"创建或者打开表失败");
        }
        else
        {
            NSLog(@"表创建成功");
            NSString * sql = @"select * from collect where applicationId = ?;";
            FMResultSet * result = [_collectDataBase executeQuery: sql, _applicationId];
            if (![result next])
            {
                NSLog(@"还没收藏");
                [_collectBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
            }
            else
            {
                NSLog(@"已收藏");
                 [_collectBtn setTitle: @"已收藏" forState: UIControlStateNormal];
                [_collectBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
            }
        }
    }
}

#pragma mark -
#pragma mark 弹出列表的方法

-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

#pragma mark -
#pragma mark 回调方法实现

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"share to QQ name is %@", [[response.data allKeys] objectAtIndex: 0]);
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
