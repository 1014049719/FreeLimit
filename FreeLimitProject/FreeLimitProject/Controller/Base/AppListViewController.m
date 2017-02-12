//
//  AppListViewController.m
//  FreeLimitProject
//
//  Created by 胡贝 on 14/12/24.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import "AppListViewController.h"
#import "FreeLimitProject-Prefix.pch"
#import "DetailViewController.h"


@interface AppListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    NSMutableArray *dataarray;
    
    HTTPrequest *request;
    
    //页面数
    int pageindex;
    //搜索
    UISearchBar *searchbar;
    UISearchDisplayController *displaycl;
        
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
    
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"navigationbar"] forBarMetrics:UIBarMetricsDefault];
   

    dataarray = [[NSMutableArray alloc] init];
    pageindex = 1;
    
    [self loadData];
    
    tableview=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    

    //添加上拉加载和下拉刷新
    [tableview addFooterWithTarget:self action:@selector(dealfoot)];
    [tableview addHeaderWithTarget:self action:@selector(dealhead)];
    
    //添加导航栏两个按钮
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"buttonbar_action.png"] forState:UIControlStateNormal];
    btn1.frame=CGRectMake(5, 5, 45, 30);
    [btn1 setTitle:@"分类" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbtn=[[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem=leftbtn;
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"buttonbar_action.png"] forState:UIControlStateNormal];
    btn2.frame=CGRectMake(320-5-45, 5, 45, 30);
    [btn2 setTitle:@"配置" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbtn=[[UIBarButtonItem alloc] initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItem=rightbtn;
    

    
    //搜索界面
    searchbar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 65, 320, 50)];
    searchbar.placeholder=@"搜索";
    displaycl=[[UISearchDisplayController alloc] initWithSearchBar:searchbar contentsController:self];
    displaycl.searchResultsDataSource=self;
    displaycl.searchResultsDelegate=self;
    tableview.tableHeaderView=searchbar;
    
}

-(void)dealfoot{
    
    pageindex ++;
    [self loadData];
    
}
-(void)dealhead{
    
    pageindex = 1;
    [self loadData];
}

-(void)loadData{
    NSString *urlstr = [NSString stringWithFormat:self.urlString,pageindex,nil];
    request=[[HTTPrequest alloc] initWithurlstring:urlstr target:self action:@selector(finishdownload:)];
}

-(void)finishdownload:(HTTPrequest *)request1{
    
    if (pageindex==1) {
        [dataarray removeAllObjects];
    }

    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:request1.downloaddata options:NSJSONReadingMutableContainers error:nil];
    NSArray *array=[dic objectForKey:@"applications"];
    for (NSDictionary *tempdic in array) {
        Mymodel *model=[[Mymodel alloc] init];
        model.icon=[tempdic objectForKey:@"iconUrl"];
        model.name=[tempdic objectForKey:@"name"];
        model.price=[tempdic objectForKey:@"lastPrice"];
        model.category=[tempdic objectForKey:@"categoryName"];
        model.share=[tempdic objectForKey:@"shares"];
        model.collect=[tempdic objectForKey:@"favorites"];
        model.download=[tempdic objectForKey:@"downloads"];
        model.star=[tempdic objectForKey:@"starOverall"];
        
        [dataarray addObject:model];
    }
    
    //刷新数据
    [tableview reloadData];
    //结束下拉刷新和上拉加载
    [tableview footerEndRefreshing];
    [tableview headerEndRefreshing];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"%d",dataarray.count);
    return dataarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"cell";
    MyCell *cell=[tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    Mymodel *model=[dataarray objectAtIndex:indexPath.row];
    [cell.iconview setImageWithURL:[NSURL URLWithString:model.icon]];
    cell.namelable.text=model.name;
    cell.pricelable.text=model.price;
    cell.categorylable.text=model.category;
    cell. sharelable.text= [NSString stringWithFormat:@"分享:%@",model.share];
    cell. collectlable.text=[NSString stringWithFormat:@"收藏:%@",model.collect];
    cell. downloadlable.text=[NSString stringWithFormat:@"下载:%@",model.download];
    [cell.starimageview setStar:model.star.doubleValue];
    
    
    return cell;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(void)btn1click:(UIButton *)btn{

}
-(void)btn2click:(UIButton *)btn{

}

//点击Cell跳转详情界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detailvcl=[[DetailViewController alloc] init];
    detailvcl.navigationItem.title=@"应用详情";
    [self.navigationController pushViewController:detailvcl animated:YES];
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
