//
//  AppListViewController.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-26.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "AppListViewController.h"
#import "FFModel.h"
#import "FFCell.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
#import "SettingViewController.h"

//#import "NetInterface.h"

@interface AppListViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate, UISearchBarDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _muArrData;
    MJRefreshFooterView * _footerView;
    MJRefreshHeaderView * _headerView;
    int _pageIndex;
    UISearchBar * _searchBar;
    UIView * _viewShade;
}

@end

@implementation AppListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏左侧的按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 30);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action.png"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"分类" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    //设置导航栏右侧的按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 30);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action.png"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"配置" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    //调用加载数据的方法
    [self loadData];
    
    //初始化tableView的数据源
    _muArrData = [[NSMutableArray alloc] init];
    
    //初始化tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-44-64) style:UITableViewStylePlain];
    
    //设置代理
    _tableView.dataSource = self;
    _tableView.delegate = self;

    [self.view addSubview:_tableView];
    
    //上拉加载更多
    _footerView = [[MJRefreshFooterView alloc] init];
    _footerView.delegate = self;
    _footerView.scrollView = _tableView;
    
    //下拉刷新
    _headerView = [[MJRefreshHeaderView alloc] init];
    _headerView.delegate = self;
    _headerView.scrollView = _tableView;
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"60万应用等你搜";
    _tableView.tableHeaderView = _searchBar;
    
    _viewShade = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 480-64)];
    _viewShade.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarCancelButtonClicked:)];
    [_viewShade addGestureRecognizer:tgr];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = YES;
    [self.view addSubview:_viewShade];
    _searchBar.placeholder = @"";
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [_viewShade removeFromSuperview];
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    _searchBar.placeholder = @"60万应用等你搜";
    _searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchViewController * svc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

//导航栏左侧按钮处理事件
-(void)leftBtnClick:(UIButton *)btn
{
    
}

//导航栏右侧按钮处理事件
-(void)rightBtnClick:(UIButton *)btn
{
    SettingViewController * svc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

//加载数据的方法
-(void)loadData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:_urlString,_pageIndex,@""] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error;
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        NSArray * arr = [dic objectForKey:@"applications"];
        
        //下拉刷新时，需要将数据源清空
        if(_pageIndex == 1)
        {
            [_muArrData removeAllObjects];
        }
        
        //给model填值
        for (NSDictionary * subDic in arr)
        {
            FFModel * model = [[FFModel alloc] init];
            model.iconUrl = [subDic objectForKey:@"iconUrl"];
            model.name = [subDic objectForKey:@"name"];
            model.currentPrice = [subDic objectForKey:@"currentPrice"];
            model.lastPrice = [subDic objectForKey: @"lastPrice"];
            model.starCurrent = [subDic objectForKey:@"starCurrent"];
            model.categoryName = [subDic objectForKey:@"categoryName"];
            model.shares = [subDic objectForKey:@"shares"];
            model.favorites = [subDic objectForKey:@"favorites"];
            model.downloads = [subDic objectForKey:@"downloads"];
            model.applicationId = [subDic objectForKey:@"applicationId"];
            
            //给数据源添加数据
            [_muArrData addObject:model];
        }
        
        //刷新tableView
        [_tableView reloadData];
        
        //停止刷新
        [_footerView endRefreshing];
        [_headerView endRefreshing];
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

//上拉加载更多和下拉刷新的处理函数
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView == _footerView)
    {
        _pageIndex ++;
    }
    else
    {
        _pageIndex = 1;
    }
    [self loadData];
}

//设置tableView需要显示的单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _muArrData.count;
}

//创建、显示单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    FFCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[FFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    FFModel * model = [_muArrData objectAtIndex:indexPath.row];
    
    //隔行变色
    if(indexPath.row % 2 == 0)
    {
        cell.imageViewBack.image = [UIImage imageNamed:@"cate_list_bg1.png"];
    }
    else
    {
        cell.imageViewBack.image = [UIImage imageNamed:@"cate_list_bg2.png"];
    }
    
    //给单元格中的各个对象赋值
    [cell.imageViewIcon setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    cell.labelName.text = [NSString stringWithFormat:@"%d. %@",indexPath.row+1,model.name];
    cell.labelCategoryName.text = model.categoryName;
    cell.labelLastPrice.text = [NSString stringWithFormat:@"%.2f",[model.lastPrice floatValue]];
    cell.labelCategoryName.text = model.categoryName;
    [cell.starView setStar:[model.starCurrent floatValue]];
    cell.labelShares.text = [NSString stringWithFormat:@"分享: %@",model.shares];
    cell.labelFavorites.text = [NSString stringWithFormat:@"收藏: %@",model.favorites];
    cell.labelDownloads.text = [NSString stringWithFormat:@"下载: %@",model.downloads];
    
    //使用正向传值，根据_pageName判断是哪个子页面，实现labelOther在不同页面中显示不同的数据
    if([_pageName isEqualToString:@"rvc"])
    {
        cell.labelOther.text = [NSString stringWithFormat:@"现价: %.2f",[model.currentPrice floatValue]];
    }
    else if([_pageName isEqualToString:@"fvc"] || [_pageName isEqualToString:@"hvc"])
    {
        cell.labelOther.text = [NSString stringWithFormat:@"评分:%@分",model.starCurrent];
    }
    return cell;
}

//设置tableView的单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//实现单元格的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到详情页
    DetailViewController * dvc = [[DetailViewController alloc] init];
    dvc.navigationItem.title = @"应用详情";
    
    //使用正向传值，将点击的单元格的applicationId的值传至详情页
    dvc.applicationId = ((FFModel *)[_muArrData objectAtIndex:indexPath.row]).applicationId;
    
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
