//
//  AppListViewController.m
//  LoveFree
//
//  Created by qianfeng on 14-12-26.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import "AppListViewController.h"
#import "LoveFree-Prefix.pch"

@interface AppListViewController () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate, ClassifyShowProtocol>
{
    @protected
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    int _pageIndex;
    
    MJRefreshHeaderView * _headerView;
    MJRefreshFooterView * _footerView;
    NSString * url;
    
    NSString * _categoryId;
    
    UISearchBar * _searchBar;
    UISearchDisplayController * _searchDisController;
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
    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed: @"navigationbar"] forBarMetrics: UIBarMetricsDefault];
    
    [self classVariateInit];
    [self pageViewAdd];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 类变量初始化

- (void)classVariateInit
{
    if (_urlString == nil) {
        _urlString = LIMIT_URL;
    }
    _categoryId = @"";
    _pageIndex = 1;
    _dataArray = [[NSMutableArray alloc] initWithCapacity: 0];
}

#pragma mark -
#pragma mark 限免页面视图添加

- (void)pageViewAdd
{
    if (![self.navigationItem.title isEqualToString: @"专题"])
    {
        UIButton * leftBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 30)];
        [leftBtn setTitle: @"分类" forState: UIControlStateNormal];
        [leftBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        [leftBtn.titleLabel setFont: [UIFont systemFontOfSize: 14]];
        [leftBtn setBackgroundImage: [UIImage imageNamed: @"buttonbar_action"] forState: UIControlStateNormal];
        [leftBtn addTarget: self action: @selector(leftBtnClick:) forControlEvents: UIControlEventTouchUpInside];
        UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView: leftBtn];
        self.navigationItem.leftBarButtonItem = leftBarBtn;
        
        UIButton * rightBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 30)];
        [rightBtn setTitle: @"配置" forState: UIControlStateNormal];
        [rightBtn setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        [rightBtn.titleLabel setFont: [UIFont systemFontOfSize: 14]];
        [rightBtn setBackgroundImage: [UIImage imageNamed: @"buttonbar_action"] forState: UIControlStateNormal];
        [rightBtn addTarget: self action: @selector(rightBtnClick:) forControlEvents: UIControlEventTouchUpInside];
        UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView: rightBtn];
        self.navigationItem.rightBarButtonItem = rightBarBtn;
    }

    _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 320, self.view.bounds.size.height - 64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _headerView = [[MJRefreshHeaderView alloc] initWithScrollView: _tableView];
    _headerView.delegate = self;
    
    _footerView = [[MJRefreshFooterView alloc] initWithScrollView: _tableView];
    _footerView.delegate = self;
    
    [self.view addSubview: _tableView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame: CGRectMake(0, 0, 320, 50)];
    _searchBar.placeholder = @"搜索";
    
    _searchDisController = [[UISearchDisplayController alloc] initWithSearchBar: _searchBar contentsController: self];
    _searchDisController.searchResultsDataSource = self;
    _searchDisController.searchResultsDelegate = self;
    if (self.tabBarController.selectedIndex != 3) {
        _tableView.tableHeaderView = _searchBar;
    }
    
}

#pragma mark -
#pragma mark 设置tableView组数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -
#pragma mark 设置tableView行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark -
#pragma mark 设置tableViewCell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tabBarController.selectedIndex == 3) {
        static NSString * identifier1 = @"TopicCell";
        TopicCell * cell = [tableView dequeueReusableCellWithIdentifier: identifier1];
        if (cell == nil) {
            cell = [[TopicCell alloc] initWithStyle: 0 reuseIdentifier: identifier1];
        }
        TopicCellModel * model = [_dataArray objectAtIndex: indexPath.row];
        cell.titleLabel.text = model.title;
        [cell.imgImageView setImageWithURL: [NSURL URLWithString: model.img]];
        [cell.desc_imgImageView setImageWithURL: [NSURL URLWithString: model.desc_img]];
        cell.descLabel.text = model.desc;
        for (int i = 0; i < 4; i++)
        {
            NSDictionary * dic = model.applications[i];
            AppShowViewModel * model = [[AppShowViewModel alloc] init];
            [model setValuesForKeysWithDictionary: dic];
            if (i == 0)
            {
                [cell.appShowView1.iconUrlImageView setImageWithURL: [NSURL URLWithString: model.iconUrl]];
                cell.appShowView1.nameLabel.text = model.name;
                cell.appShowView1.downloadsLabel.text = model.downloads;
                cell.appShowView1.commentLabel.text = [NSString stringWithFormat: @"%d", [model.comment intValue]];
                cell.appShowView1.applicationId = model.applicationId;
                [cell.appShowView1.starOverallStartView setStar: [model.starOverall floatValue]];
            }
            else if (i == 1)
            {
                [cell.appShowView2.iconUrlImageView setImageWithURL: [NSURL URLWithString: model.iconUrl]];
                cell.appShowView2.nameLabel.text = model.name;
                cell.appShowView2.downloadsLabel.text = model.downloads;
                cell.appShowView2.commentLabel.text = [NSString stringWithFormat: @"%d", [model.comment intValue]];
                cell.appShowView2.applicationId = model.applicationId;
                [cell.appShowView2.starOverallStartView setStar: [model.starOverall floatValue]];
            }
            else if(i == 2)
            {
                [cell.appShowView3.iconUrlImageView setImageWithURL: [NSURL URLWithString: model.iconUrl]];
                cell.appShowView3.nameLabel.text = model.name;
                cell.appShowView3.downloadsLabel.text = model.downloads;
                cell.appShowView3.commentLabel.text = [NSString stringWithFormat: @"%d", [model.comment intValue]];
                cell.appShowView3.applicationId = model.applicationId;
                [cell.appShowView3.starOverallStartView setStar: [model.starOverall floatValue]];
            }
            else
            {
                [cell.appShowView4.iconUrlImageView setImageWithURL: [NSURL URLWithString: model.iconUrl]];
                cell.appShowView4.nameLabel.text = model.name;
                cell.appShowView4.downloadsLabel.text = model.downloads;
                cell.appShowView4.commentLabel.text = [NSString stringWithFormat: @"%d", [model.comment intValue]];
                cell.appShowView4.applicationId = model.applicationId;
                [cell.appShowView4.starOverallStartView setStar: [model.starOverall floatValue]];
            }
        }
        return cell;
    }
    else
    {
        static NSString * identifier = @"LimitFreeCell";
        LimitFreeCell * cell = [tableView dequeueReusableCellWithIdentifier: identifier];
        if (cell == nil) {
            cell = [[LimitFreeCell alloc] initWithStyle: 0 reuseIdentifier: identifier];
        }
        LimitFreeCellModel * model = [_dataArray objectAtIndex: indexPath.row];
        [cell.iconUrlImageView setImageWithURL: [NSURL URLWithString: model.iconUrl]];
        [cell.starCurrentStarView setStar: [model.starCurrent floatValue]];
        cell.nameLabel.text = [NSString stringWithFormat: @"%d. %@", indexPath.row + 1, model.name];
        cell.lastPriceLabel.text = [NSString stringWithFormat: @"￥%.2f", [model.lastPrice floatValue]];
        cell.categoryNameLabel.text = model.categoryName;
        cell.sharesLabel.text = [NSString stringWithFormat: @"分享: %@", model.shares];
        cell.favoritesLabel.text = [NSString stringWithFormat: @"收藏: %@", model.favorites];
        cell.downloadsLabel.text = [NSString stringWithFormat: @"下载: %@", model.downloads];
        return cell;
    }
}

#pragma mark -
#pragma mark 返回cell的行高度

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tabBarController.selectedIndex == 3) {
        return 308;
    }
    return 100;
}

#pragma mark -
#pragma mark 发送get请求，从接口获取数据

- (void)getData
{
    if (self.tabBarController.selectedIndex == 3) {
        url = [NSString stringWithFormat: _urlString, _pageIndex];
        url = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET: url parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (_pageIndex == 1)
            {
                [_dataArray removeAllObjects];
            }
            NSError * error;
            NSArray * resultArray = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error: &error];
            for (NSDictionary * dic in resultArray) {
                TopicCellModel * model = [[TopicCellModel alloc] init];
                [model setValuesForKeysWithDictionary: dic];
                [_dataArray addObject: model];
            }
            
            [_tableView reloadData];
            [_headerView endRefreshing];
            [_footerView endRefreshing];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    else
    {
        url = [NSString stringWithFormat: _urlString, _pageIndex, _categoryId];
        url = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET: url parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (_pageIndex == 1)
            {
                [_dataArray removeAllObjects];
            }
            NSError * error;
            NSDictionary * resultDic = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error: &error];
//            NSLog(@"resultDic = %@", resultDic);
            NSArray * arr = [resultDic objectForKey: @"applications"];
            for (int i = 0; i < arr.count; i++) {
                LimitFreeCellModel * model = [[LimitFreeCellModel alloc] init];
                [model setValuesForKeysWithDictionary: arr[i]];
                [_dataArray addObject: model];
            }
            [_tableView reloadData];
            [_headerView endRefreshing];
            [_footerView endRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

#pragma mark -
#pragma mark 上拉加载更多以及下拉刷新

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _headerView)
    {
        _pageIndex = 1;
        [self getData];
    }
    else if(refreshView == _footerView)
    {
        _pageIndex++;
        [self getData];
    }
}

#pragma mark -
#pragma mark 分类按钮点击事件

- (void)leftBtnClick:(UIButton *)btn
{
    ClassifyViewController * classifyVC = [[ClassifyViewController alloc] init];
    classifyVC.delegate = self;
    if ([self.navigationItem.title isEqualToString: @"限免"])
    {
        classifyVC.priceTrend = @"limited";
    }
    else if ([self.navigationItem.title isEqualToString: @"免费"])
    {
        classifyVC.priceTrend = @"free";
    }
    else if ([self.navigationItem.title isEqualToString: @"降价"])
    {
        classifyVC.priceTrend = @"down";
    }
    else if ([self.navigationItem.title isEqualToString: @"热榜"])
    {
        classifyVC.priceTrend = @"hot";
    }
        
    [self.navigationController pushViewController: classifyVC animated: YES];
}

#pragma  mark -
#pragma  mark 配置按钮点击事件

- (void)rightBtnClick:(UIButton *)btn
{
    ConfigViewController * configVC = [[ConfigViewController alloc] init];
    [self.navigationController pushViewController: configVC animated: YES];
}

#pragma mark -
#pragma mark 选中进入详情页面

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tabBarController.selectedIndex != 3) {
        DetailViewController * detailVC = [[DetailViewController alloc] init];
        LimitFreeCellModel * model = [_dataArray objectAtIndex: indexPath.row];
        detailVC.appId = model.applicationId;
        [self.navigationController pushViewController: detailVC animated: YES];
    }
    else
    {
        TopicCell * topicCell = (TopicCell *)[_tableView cellForRowAtIndexPath: indexPath];
        topicCell.appShowView1.userInteractionEnabled = YES;
        topicCell.appShowView2.userInteractionEnabled = YES;
        topicCell.appShowView3.userInteractionEnabled = YES;
        topicCell.appShowView4.userInteractionEnabled = YES;
    }
}

#pragma mark -
#pragma mark 反选取消tableViewCell接收响应

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tabBarController.selectedIndex == 3)
    {
        TopicCell * topicCell = (TopicCell *)[_tableView cellForRowAtIndexPath: indexPath];
        topicCell.appShowView1.userInteractionEnabled = NO;
        topicCell.appShowView2.userInteractionEnabled = NO;
        topicCell.appShowView3.userInteractionEnabled = NO;
        topicCell.appShowView4.userInteractionEnabled = NO;
    }
}

#pragma mark -
#pragma mark 实现分类页面协议返回设置CategoryId的方法

- (void)setCategoryId:(NSString *)categoryId
{
    _categoryId = categoryId;
    _pageIndex = 1;
    [self getData];
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
