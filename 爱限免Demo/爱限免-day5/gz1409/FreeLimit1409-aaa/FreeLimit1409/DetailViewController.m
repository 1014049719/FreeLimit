//
//  DetailViewController.m
//  FreeLimit1409
//
//  Created by mac on 14-11-28.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "DetailViewController.h"

#import <CoreLocation/CoreLocation.h>

#import "NearByAppView.h"

#import "DatabaseManager.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "TencentOpenAPI/TencentOAuth.h"

@interface DetailViewController ()<CLLocationManagerDelegate,UIActionSheetDelegate>
{
    ZJHttpRequest *_httpRequest;
    
    UIImageView *topView;
    
    //定位管理器对象
    CLLocationManager *_locationManager;
    
    ZJHttpRequest *_nearByRequest;
    
    NSMutableArray *_nearByAppArray;
    
    UIImageView *_bottomView;
    
    UIScrollView *_nearByScrollView;
    
    //为了在下载完成之后再次赋值
    UILabel *priceLabel;
    UILabel *typeLabel;
    UILabel *sizeLabel;
    UILabel *starLabel;
    UILabel *descLabel;
    
    UIImageView *iconView;
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
    
    [self configNavigation];
    
    //创建顶部视图
    [self createTopUI];
    
    
    //创建底部视图
    [self createBottomUI];
    
    
}
#pragma mark - 底部视图
-(void)createBottomUI
{
    //添加背景图图片
    _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 285 , 300, 80)];
    _bottomView.image = [UIImage imageNamed:@"appdetail_recommend.png"];
    _bottomView.userInteractionEnabled = YES;
    [self.view addSubview:_bottomView];
    
    
    
    //获取当前经纬度
    //如何获取: 使用 CoreLocation 核心定位
    //库的配置
    //1.添加 CoreLocation.framework
    //2.添加头文件
    //  #import <CoreLocation/CoreLocation.h>
    
    //检测定位服务是否开启
    if([CLLocationManager locationServicesEnabled])
    {
        _locationManager = [[CLLocationManager alloc] init];
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        _locationManager.distanceFilter = 1000;
        //开始定位
        [_locationManager startUpdatingLocation];
        
        //为了获取定位数据
        //遵守: CLLocationManagerDelegate
        _locationManager.delegate = self;
    }
    
    //ZJLocation
}

//代理方法: 一旦定位成功之后执行
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
   //获取经纬度
    //模拟器模拟当前经纬度
    //  调试-->位置-->选择apple或者自定义位置
    CLLocationCoordinate2D coordinate = manager.location.coordinate;
    //NSLog(@"long=%f lan=%f",coordinate.longitude,coordinate.latitude);
    
    //根据当前位置下载附近的应用数据
    NSString *urlString = [NSString stringWithFormat:NEARBY_APP_URL,coordinate.longitude,coordinate.latitude];
    _nearByRequest = [[ZJHttpRequest alloc] initWithURLString:urlString success:^(NSData *data) {
        
        _nearByAppArray = [[NSMutableArray alloc] init];
        
        //解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *appList = dict[@"applications"];
        for (NSDictionary *appDict in appList) {
            AppModel *model = [[AppModel alloc] init];
            [model setValuesForKeysWithDictionary:appDict];
            [_nearByAppArray addObject:model];
        }
        
        //数据解析完成
        [self createNearByScrollView];
    }];
}

-(void)createNearByScrollView
{
    //底部 10, 282 , 300, 90
    
    _nearByScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 5, 280, 80)];
    _nearByScrollView.showsHorizontalScrollIndicator = NO;
    _nearByScrollView.showsVerticalScrollIndicator = NO;
    [_bottomView addSubview:_nearByScrollView];
    
    double w = (280 - 4*5)/5.0; //260/5=52
    double h = 65;
    for (int i=0; i<_nearByAppArray.count; i++) {
        AppModel *model = _nearByAppArray[i];
        
        double x = (w + 5) * i;
        double y = 15;
        NearByAppView *appView = [[NearByAppView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [appView.imageView setImageWithURL:[NSURL URLWithString:model.iconUrl]];
        appView.label.text = model.name;
        appView.model = model;
        [_nearByScrollView addSubview:appView];
    }
    _nearByScrollView.contentSize = CGSizeMake((w+5)*_nearByAppArray.count, 80);
}




#pragma mark - 顶部视图
-(void)createTopUI
{
    //显示view
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 3, 300, 280)];
    topView.image = [UIImage imageNamed:@"appdetail_background.png"];
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    
    //图标
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    [iconView setImageWithURL:[NSURL URLWithString:self.model.iconUrl]];
    [topView addSubview:iconView];
    
    //UIView+QuickAdd
    //ZJQuickControl
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 8, 300-100, 30)];
    titleLabel.text = self.model.name;
    [topView addSubview:titleLabel];
    
    //price
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 28, 300-100, 30)];
    priceLabel.text = [NSString stringWithFormat:@"原价:¥%.2f",self.model.lastPrice.doubleValue];
    priceLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:priceLabel];
    
    //类型
    typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 300-100, 30)];
    typeLabel.text = [NSString stringWithFormat:@"类型:%@",self.model.categoryName];
    typeLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:typeLabel];
    
    //size
    sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 28, 300-100, 30)];
    sizeLabel.text = [NSString stringWithFormat:@"大小:%@MB",self.model.fileSize];
    sizeLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:sizeLabel];
    
    //star
    starLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 50, 300-100, 30)];
    starLabel.text = [NSString stringWithFormat:@"评分:%.1f分",self.model.starCurrent.doubleValue];
    starLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:starLabel];
    
    //添加三个按钮
    NSArray *titleArray = @[@"分享",@"收藏",@"下载"];
    
    for (int i=0; i<titleArray.count; i++)
    {
        // 0, 90, 100, 40
        double w = 99;
        double h = 40;
        double x = 1+w*i;
        double y = 90;
        UIButton *button = [UIButton imageButtonWithFrame:CGRectMake(x, y, w, h) title:titleArray[i] image:@"Detail_btn_left.png" action:^(UIButton *button) {
            
            //点击分享
            if(button.tag == 100)
            {
                //打开actionSheet
                // 遵守 UIActionSheetDelegate
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博",@"微信圈子",@"微信好友",@"邮件",@"短信", nil];
                [actionSheet showInView:self.view];
            }
            
            
            //点了收藏
            if(button.tag == 101)
            {
                DatabaseManager *manager = [DatabaseManager sharedInstance];
                if([manager isExistRecordWithAppModel:self.model recordType:RecordTypeFavorite])
                {
                    //说明, 取消收藏, 显示 收藏
                    [manager removeRecordWithAppModel:self.model recordType:RecordTypeFavorite];
                    [button setTitle:@"收藏" forState:UIControlStateNormal];
                }
                else
                {
                    [manager addRecordWithAppModel:self.model recordType:RecordTypeFavorite];
                    [button setTitle:@"取消收藏" forState:UIControlStateNormal];
                }
            }
            
            
            //点了下载
            if(button.tag == 102)
            {
                //打开网址
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.model.itunesUrl]];
            }
        }];
        button.tag = 100 +i;
        [topView addSubview:button];
        
        if(button.tag == 101)
        {
            //根据应用是否被收藏显示 收藏 或 取消收藏
            if([[DatabaseManager sharedInstance] isExistRecordWithAppModel:self.model recordType:RecordTypeFavorite])
            {
                [button setTitle:@"取消收藏" forState:UIControlStateNormal];
            }
        }
        
    }
    
    //开始下载应用的详情数据
    NSString *urlString = [NSString stringWithFormat:DETAIL_URL,self.model.applicationId.intValue];
    _httpRequest = [[ZJHttpRequest alloc] initWithURLString:urlString success:^(NSData *data) {
        
        //获取数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //model补全了
        [self.model setValuesForKeysWithDictionary:dict];
        priceLabel.text = [NSString stringWithFormat:@"原价:¥%.2f",self.model.lastPrice.doubleValue];
        sizeLabel.text = [NSString stringWithFormat:@"大小:¥%.2f",self.model.fileSize.doubleValue];
        typeLabel.text = [NSString stringWithFormat:@"类型:%@",self.model.categoryName];
        starLabel.text = [NSString stringWithFormat:@"评分:%.2f",self.model.starCurrent.doubleValue];
        descLabel.text = self.model.description;
        
        
        //获取截图数组
        self.model.photos = dict[@"photos"];
        
        //创建scrollView显示数据
        [self createScrollView];
    }];
    
    //添加描述标签
    descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 215, 280, 60)];
    descLabel.text = self.model.description;
    descLabel.numberOfLines = 0;
    descLabel.font = [UIFont systemFontOfSize:12];
    [topView addSubview:descLabel];
    
}

//actionSheet点击处理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //410527965@qq.com
    //qianfeng1409
    
    
    //点击了分享按钮
    if(buttonIndex < 5)
    {
        //实现分享
        //定义分享方式
        NSArray *shareWay = @[UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToEmail,UMShareToSms];
        
        //分享的时候执行以下代码即可
	    [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"%@ 应用太好玩了, 大家快来玩吧",self.model.name] shareImage:iconView.image socialUIDelegate:nil];     //设置分享内容和回调对象
        
        [UMSocialSnsPlatformManager getSocialPlatformWithName:shareWay[buttonIndex]].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
    
    // ZJShareSDK
}


-(void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 135, 280, 88)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [topView addSubview:scrollView];
    
    double w = (280 - 4*5)/5.0;
    double h = 80;
    for(int i=0; i<self.model.photos.count; i++)
    {
        
        double x = (w + 5)*i;
        double y = 4;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [imageView setImageWithURL:[NSURL URLWithString:self.model.photos[i][@"smallUrl"]]];
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake((w + 5)*self.model.photos.count, 88);
}

#pragma mark - 导航条设置

-(void)configNavigation
{
    //显示标题
    //修改导航条文本颜色
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"应用详情";
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    //设置返回按钮
    UIButton *button = [UIButton imageButtonWithFrame:CGRectMake(0, 0, 45, 30) title:@"返回" image:@"buttonbar_back.png" action:^(UIButton *button) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    
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
