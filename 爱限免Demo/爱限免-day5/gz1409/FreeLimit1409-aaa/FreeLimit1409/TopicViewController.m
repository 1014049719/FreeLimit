//
//  TopicViewController.m
//  FreeLimit1409
//
//  Created by mac on 14-11-27.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "TopicViewController.h"

#import "TopicModel.h"

#import "TopicCell.h"

#import "AppModel.h"

#import "MJRefresh/MJRefresh.h"

#import "DetailViewController.h"

@interface TopicViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //当前页数
    int _page;
    NSMutableArray *_dataArray;
    ZJHttpRequest *_httpRequest;
    UITableView *_tableView;
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
    // Do any additional setup after loading the view.
    
    [self configNavigation];
    
    //1.接口和图片
    //2.数据下载和处理
    _page = 1;
    _dataArray = [[NSMutableArray alloc] init];
    [self downloadData];
    //3.数据的显示
    [self createTableView];
    
    
    //封装常用代码 例如创建model
    //封装tableView

}
-(void)configNavigation
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView addHeaderWithTarget:self action:@selector(dealRefresh)];
    [_tableView addFooterWithTarget:self action:@selector(dealLoadMore)];
}
-(void)dealRefresh
{
    _page = 1;
    [self downloadData];
}
-(void)dealLoadMore
{
    _page++;
    [self downloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[TopicCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    //config cell
    TopicModel *model = _dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.img]];
    [cell.descImageView setImageWithURL:[NSURL URLWithString:model.desc_img]];
    cell.descLabel.text = model.desc;
    
    //cell的4个appView设置值
    for (int i=0; i<model.applications.count; i++)
    {
        AppModel *appModel = model.applications[i];
        TopicAppView *appView = cell.appViewArray[i];
        [appView.iconImageView setImageWithURL:[NSURL URLWithString:appModel.iconUrl]];
        appView.nameLabel.text = appModel.name;
        appView.commentLabel.text = [NSString stringWithFormat:@"%d",appModel.comment.intValue];
        appView.downloadLabel.text = appModel.downloads;
        [appView.starView setStar:appModel.starCurrent.doubleValue];
        
        //为了处理点击
        appView.model = appModel;
        [cell setAppViewAction:^(TopicAppView *view, AppModel *model) {
            //NSLog(@"click %@",model.name);
            DetailViewController *dvc = [[DetailViewController alloc] init];
            dvc.model = model;
            [self.navigationController pushViewController:dvc animated:YES];
        }];
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 308.0;
}

-(void)downloadData
{
    NSString *urlString = [NSString stringWithFormat:TOPIC_URL,_page];
    _httpRequest = [[ZJHttpRequest alloc] initWithURLString:urlString success:^(NSData *data) {
        
        NSArray *topicArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if(_page == 1)
        {
            [_dataArray removeAllObjects];
        }
        for (NSDictionary *topicDict in topicArray)
        {
            TopicModel *model = [[TopicModel alloc] init];
            [model setValuesForKeysWithDictionary:topicDict];
            
            //处理专题中的应用数据
            NSArray *applications = topicDict[@"applications"];
            NSMutableArray *marr = [[NSMutableArray alloc] init];
            for (NSDictionary *appDict in applications)
            {
                AppModel *appModel = [[AppModel alloc] init];
                [appModel setValuesForKeysWithDictionary:appDict];
                [marr addObject:appModel];
            }
            model.applications = marr;
            
            
            [_dataArray addObject:model];
        }
        
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
        [_tableView footerEndRefreshing];
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
