//
//  ClassifyViewController.m
//  LoveFree
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import "ClassifyViewController.h"
#import "LoveFree-Prefix.pch"

@interface ClassifyViewController () <UITableViewDataSource, UITableViewDelegate, MJRefreshBaseViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
}

@end

@implementation ClassifyViewController

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
    self.navigationItem.title = [NSString stringWithFormat: @"%@分类", self.navigationController.navigationItem.title];
    _dataArray = [[NSMutableArray alloc] initWithCapacity: 0];
    [self createUI];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark 创建分类页面视图

- (void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 320, self.view.frame.size.height - 64) style: UITableViewStylePlain];
    [self.view addSubview: _tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
}

#pragma mark -
#pragma mark 下载数据

- (void)getData
{
    NSString * urlString = [NSString stringWithFormat: CATE_URL];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET: urlString parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error;
        NSArray * array = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error: &error];
        for (NSDictionary * dic in array)
        {
            ClassifyModel * model = [[ClassifyModel alloc] init];
            model.category_id = [dic objectForKey: @"category_id"];
            model.category_count = [dic objectForKey: @"category_count"];
            model.category_name = [dic objectForKey: @"category_name"];
            model.category_cname = [dic objectForKey: @"category_cname"];
            model.priceTrendDic = [[NSMutableDictionary alloc] initWithCapacity: 0];
            NSString * limited = [dic objectForKey: @"limited"];
            NSString * free = [dic objectForKey: @"free"];
            NSString * down = [dic objectForKey: @"down"];
            NSString * hot = @"前300";
            [model.priceTrendDic setObject: limited forKey: @"limited"];
            [model.priceTrendDic setObject: free forKey: @"free"];
            [model.priceTrendDic setObject: down forKey: @"down"];
            [model.priceTrendDic setObject: hot forKey: @"hot"];
            [_dataArray addObject: model];
            [_tableView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

#pragma mark -
#pragma mark 设置行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark -
#pragma mark 设置cell大小

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark -
#pragma mark 设置cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"ClassifyCell";
    
    ClassifyCell * cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if (cell == nil) {
        cell = [[ClassifyCell alloc] initWithStyle: 0 reuseIdentifier: identifier];
    }
    ClassifyModel * model = [_dataArray objectAtIndex: indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed: [NSString stringWithFormat: @"category_%@.jpg", model.category_name]];
    cell.categoryNameLabel.text = model.category_cname;
    cell.categoryDetailLabel.text = [NSString stringWithFormat: @"共有%@款应用,其中%@%@款", model.category_count, self.navigationController.navigationItem.title, [model.priceTrendDic objectForKey: _priceTrend]];
    return cell;
}

#pragma mark -
#pragma mark didSelectRowAtIndexPath选中cell触发的事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate setCategoryId: [[_dataArray objectAtIndex: indexPath.row] category_id]];
    [self.navigationController popViewControllerAnimated: YES];
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
