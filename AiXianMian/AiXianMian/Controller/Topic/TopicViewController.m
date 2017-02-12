
//
//  TopicViewController.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-26.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "TopicViewController.h"
#import "FFTopicCell.h"
#import "TopicButton.h"
#import "FFTopicModel.h"
#import "FFTopicButtonModel.h"
#import "DetailViewController.h"

@interface TopicViewController ()<UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _muArrData;
    NSMutableArray * _muArrBtnData;
    MJRefreshFooterView * _footerView;
    MJRefreshHeaderView * _headerView;
    int _pageIndex;
}
@end

@implementation TopicViewController

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
    
    //初始化tableView的数据源
    _muArrData = [[NSMutableArray alloc] init];
    
    //初始化tableView的cell中的TopicButton的数据源
    _muArrBtnData = [[NSMutableArray alloc] init];
    
    _pageIndex = 1;
    
    [self loadData];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64-49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview: _tableView];
    
    _footerView = [[MJRefreshFooterView alloc] init];
    _footerView.delegate = self;
    _footerView.scrollView = _tableView;
    
    _headerView = [[MJRefreshHeaderView alloc] init];
    _headerView.delegate = self;
    _headerView.scrollView = _tableView;
    
    
}

-(void)loadData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:TOPIC_URL,_pageIndex] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if(_pageIndex == 1)
        {
            [_muArrData removeAllObjects];
            [_muArrBtnData removeAllObjects];
        }
        
        for (NSDictionary * dic in arr)
        {
            FFTopicModel * topicModel = [[FFTopicModel alloc] init];
            topicModel.title = [dic objectForKey:@"title"];
            topicModel.img = [dic objectForKey:@"img"];
            topicModel.desc_img = [dic objectForKey:@"desc_img"];
            topicModel.desc = [dic objectForKey:@"desc"];
            
            topicModel.applications = [dic objectForKey:@"applications"];
            
            //数组arr存的是每个cell中的4个TopicButton的数据
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            for (NSDictionary * btnDic in topicModel.applications)
            {
                FFTopicButtonModel * btnModel = [[FFTopicButtonModel alloc] init];
                btnModel.applicationId = [btnDic objectForKey:@"applicationId"];
                btnModel.name = [btnDic objectForKey:@"name"];
                btnModel.iconUrl = [btnDic objectForKey:@"iconUrl"];
                btnModel.starOverall = [btnDic objectForKey: @"starOverall"];
                btnModel.downloads = [btnDic objectForKey:@"downloads"];
                btnModel.comment = [btnDic objectForKey:@"comment"];
                [arr addObject:btnModel];
            }
            
            //_muArrBtnData存着arr，有多少个cell就用多少个arr
            [_muArrBtnData addObject:arr];
            [_muArrData addObject:topicModel];
        }
        [_tableView reloadData];
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_muArrData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 308;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    FFTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[FFTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    FFTopicModel * topicModel = [_muArrData objectAtIndex:indexPath.row];
    cell.labelTitle.text = topicModel.title;
    [cell.imageViewImg setImageWithURL:[NSURL URLWithString:topicModel.img]];
    cell.labelDesc.text = topicModel.desc;
    [cell.imageViewDesc setImageWithURL:[NSURL URLWithString:topicModel.desc_img]];
    
    for (int i = 0; i < cell.arrAppShowView.count; i ++)
    {
        TopicButton * btn = cell.arrAppShowView[i];
        FFTopicButtonModel * btnModel = _muArrBtnData[indexPath.row][i];
        
        //设置btn的applicationId属性，为点击时进行正向传值至详情页面
        btn.applicationId = btnModel.applicationId;
        
        [btn.imageViewIcon setImageWithURL:[NSURL URLWithString:btnModel.iconUrl]];
        
        btn.labelName.text = btnModel.name;
        
        btn.labelComment.text = [btnModel.comment stringValue];
        
        btn.labelDownloads.text = btnModel.downloads;
        
        [btn.starView setStar:[btnModel.starOverall floatValue]];
        
        [btn addTarget:self action:@selector(topicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

-(void)topicBtnClick:(TopicButton *)topicBtn
{
    DetailViewController * dvc = [[DetailViewController alloc] init];
    dvc.applicationId = topicBtn.applicationId;
    [self.navigationController pushViewController:dvc animated:YES];
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView == _headerView)
    {
        _pageIndex = 1;
    }
    else
    {
        _pageIndex ++;
    }
    [self loadData];
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
