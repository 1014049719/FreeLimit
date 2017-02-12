//
//  AppListViewController.m
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "AppListViewController.h"

#import "AppModel.h"

#import "AppCell.h"

#import "MJRefresh/MJRefresh.h"

#import "DetailViewController.h"

#import "CategoryViewController.h"

#import <objc/runtime.h>

#import "SettingViewController.h"

#import "MMProgressHUD.h"

@interface AppListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    int _page;
    NSString *_categoryId;
    ZJHttpRequest *_httpRequest;
    
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    //遵守: UISearchBarDelegate
    UISearchBar *_searchBar;
    
}

@end

@implementation AppListViewController

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
    _page = 1;
    //爱限免接口 类别如果为空, 显示所有
    _categoryId = @"";
    _dataArray = [[NSMutableArray alloc] init];
    [self startDownloadData];
    
    [self configNavigation];
    
    [self createTableView];
    
    //改变状态栏,背景黑色, 文本白色
    //plist
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //修改导航条文本颜色
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = self.title;
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    /*
    AppModel *model = [[AppModel alloc] init];
    
    int i;
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([model class], &propertyCount);
    NSLog(@"count = %d",propertyCount);
    for ( i=0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = propertyList + i;
        const char* propertyName = property_getName(*thisProperty);
        NSLog(@"Person has a property: '%s'", propertyName);
    }
    */
}



#pragma mark - 表格事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc] init];
    //正向传值
    dvc.model = _dataArray[indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma mark - 设置导航栏
-(void)configNavigation
{
    //
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *categoryButton = [UIButton imageButtonWithFrame:CGRectMake(0, 0, 45, 30) title:@"分类" image:@"buttonbar_action.png" action:^(UIButton *button) {
        NSLog(@"打开分类界面");
        
        //
        CategoryViewController *cvc = [[CategoryViewController alloc] init];
        //打开之前界面传值
        [cvc setChangeCategoryAction:^(NSString *categoryID) {
            
            //设置当前分类
            _categoryId = categoryID;
            
            //重新下载数据
            _page = 1;
            [self startDownloadData];
            
        }];
        
        [self.navigationController pushViewController:cvc animated:YES];
        
    }];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:categoryButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *configButton = [UIButton imageButtonWithFrame:CGRectMake(0, 0, 45, 30) title:@"配置" image:@"buttonbar_action.png" action:^(UIButton *button) {
        NSLog(@"打开配置界面");
        
        SettingViewController *svc = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:svc animated:YES];
    }];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:configButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}



#pragma mark - 创建表格
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //添加下拉刷新
    //添加上拉加载更多
    [_tableView addHeaderWithTarget:self action:@selector(dealRefresh)];
    [_tableView addFooterWithTarget:self action:@selector(dealLoadMore)];
    
    //添加搜索输入
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"60万款应用搜搜看";
    _tableView.tableHeaderView = _searchBar;
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [_searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"搜索关键字 %@",searchBar.text);
    
    //项目中: 把搜索关键字传入到搜索界面执行搜索
}




-(void)dealRefresh
{
    _page = 1;
    [self startDownloadData];
}
-(void)dealLoadMore
{
    _page++;
    [self startDownloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[AppCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    
    //config cell
    cell.back.image = [UIImage imageNamed:[NSString stringWithFormat:@"cate_list_bg%d.png",indexPath.row%2+1]];
    
    AppModel *model = _dataArray[indexPath.row];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    cell.titleLabel.text = [NSString stringWithFormat:@"%d.%@",indexPath.row+1,model.name];
    
    //infoLabel随着界面的不同, 显示的数据也不同
    if(self.type == LIMTI)
    {
        //显示限免时间        expire(截止时间)
        //2014-11-27 18:52:51.0
        //  剩余: 02:28:47
        //剩余时间 = 截止时间(NSDate) - 当期时间(NSDate)
        //NSLog(@"time = %@",model.expireDatetime);
        
        //作用: 把时间和字符串相互转化
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd HH:mm:ss.S";
        NSDate *expireDate = [df dateFromString:model.expireDatetime];
        
        NSTimeInterval interval = [expireDate timeIntervalSinceDate:[NSDate date]];
        cell.infoLabel.text = [NSString stringWithFormat:@"剩余:%02d:%02d:%02d",(int)interval/60/60,(int)interval/60%60,(int)interval%60];
        
    }
    else if (self.type == SALE)
    {
        //显示现价
        cell.infoLabel.text = [NSString stringWithFormat:@"现价:¥%.2f",model.currentPrice.doubleValue];
    }
    else if (self.type == FREE || self.type == HOT)
    {
        //显示评分
        cell.infoLabel.text = [NSString stringWithFormat:@"评分: %.1f分",model.starCurrent.doubleValue];
    }
    

    
    [cell.starView setStar:model.starCurrent.doubleValue];
    //cell.infoLabel
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%.1f",model.lastPrice.doubleValue];
    [cell.priceLabel setStrikeLine];
    cell.categoryLabel.text = model.categoryName;
    cell.shareLabel.text = [NSString stringWithFormat:@"分享: %@次",model.shares];
    cell.favoriteLabel.text = [NSString stringWithFormat:@"收藏: %@次",model.favorites];
    cell.downloadLabel.text = [NSString stringWithFormat:@"下载: %@次",model.downloads];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

#pragma mark - 下载数据

-(void)startDownloadData
{
    //打开网络活动提示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    //注意:MMProgressHUD第一次显示的时候为止不对
    //设置第一次不要显示
    static BOOL isFirstShow = NO;
    if(!isFirstShow)
    {
        isFirstShow = YES;
    }
    else
    {
        
        //显示正在下载
        //设置呈现的风格
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
        [MMProgressHUD showProgressWithStyle:MMProgressHUDProgressStyleIndeterminate title:@"下载提示" status:@"正在下载"];
    }

    
    
    //生成请求字符串
    NSString *urlString = [NSString stringWithFormat:self.urlString,_page,_categoryId];
    //下载
    _httpRequest = [[ZJHttpRequest alloc] initWithURLString:urlString success:^(NSData *data) {
        
        //如果从第一页下载, 刷新了
        if(_page == 1)
        {
            [_dataArray removeAllObjects];
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *appList = dict[@"applications"];
        for (NSDictionary *appDict in appList) {
            //NSLog(@"name = %@",appDict[@"name"]);
            
            AppModel *model = [[AppModel alloc] init];
            [model setValuesForKeysWithDictionary:appDict];
            [_dataArray addObject:model];
        }
        
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];

        //停止显示HUD
        [MMProgressHUD dismissWithSuccess:@"下载完成"];
        
        //关闭网络活动提示
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

//实现一个辅助方法, 传入字典, 生成model的代码
-(void)createModelWithDictionary:(NSDictionary *)dict modeName:(NSString *)modelName
{
    printf("\n@interface %s : NSObject\n",modelName.UTF8String);
    for (NSString *key in dict) {
        printf("@property (copy,nonatomic) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
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
