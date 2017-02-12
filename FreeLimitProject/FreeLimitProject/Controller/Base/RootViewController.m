//
//  RootViewController.m
//  FreeLimitProject
//
//  Created by 胡贝 on 14/12/24.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import "RootViewController.h"
#import "AFNetworking.h"
#import "TopicCell.h"
#import "Topicmodel.h"
#import "FreeLimitProject-Prefix.pch"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *tableview;
    NSMutableArray *dataarray;
    
    HTTPrequest *request;
    int pageindex;
}
@end

@implementation RootViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    dataarray=[[NSMutableArray alloc] init];
    
    pageindex=1;
    [self loadData];
    
    tableview=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    //刷新
    [tableview addHeaderWithTarget:self action:@selector(dealhead)];
    [tableview addFooterWithTarget:self action:@selector(dealfoot)];
}
-(void)dealfoot{

    pageindex++;
    [self loadData];
}
-(void)dealhead{

    pageindex=1;
    [self loadData];
}

-(void)loadData{

    if (pageindex==1) {
        [dataarray removeAllObjects];
    }
    
    NSString *urlstr=[NSString stringWithFormat:self.urlString,pageindex];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSError *error;
        NSArray *resultarray=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        NSLog(@"%@",resultarray);
        
        for (NSDictionary *dic in resultarray) {
            Topicmodel *model=[[Topicmodel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSMutableArray *marry = [[NSMutableArray alloc] init];
            
            for (NSDictionary *appdic in [dic objectForKey:@"applications"]) {
                Topicmodel *model=[[Topicmodel alloc] init];
                [model setValuesForKeysWithDictionary:appdic];
                [marry addObject:model];
            }
            model.applications = marry;
            [dataarray addObject:model];
            NSLog(@"%@",model.title);
            NSLog(@"%d",dataarray.count);
        }
        [tableview reloadData];
        [tableview headerEndRefreshing];
        [tableview footerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取数据失败");
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier=@"cell";
    TopicCell *cell=[tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[TopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Topicmodel *model=[dataarray objectAtIndex:indexPath.row];
    cell.titleLabel.text=model.title;
    [cell.desc_imgImageView setImageWithURL:[NSURL URLWithString:model.desc_img]];
    cell.descLabel.text=model.desc;
    [cell.imgImageView setImageWithURL:[NSURL URLWithString:model.img]];
    cell.datalabel.text=model.date;
   
    NSArray *array = model.applications;
    for (int i=0; i<4; i++) {
        
        Topicmodel *appmodel = array[i];

        if (i==0) {
            cell.showview1.nameLabel.text=appmodel.name;
            //星级
            [cell.showview1.starOverallStartView setStar:appmodel.starOverall.doubleValue];
            [cell.showview1.iconUrlImageView setImageWithURL:[NSURL URLWithString:appmodel.iconUrl]];
            cell.showview1.downloadsLabel.text =appmodel.downloads;
            cell.showview1.commentLabel.text=[NSString stringWithFormat:@"%d",[appmodel.comment intValue]];
        }
        if (i==1) {
            cell.showview2.nameLabel.text=appmodel.name;
            [cell.showview2.starOverallStartView setStar:appmodel.starOverall.doubleValue];
            [cell.showview2.iconUrlImageView setImageWithURL:[NSURL URLWithString:appmodel.iconUrl]];
            cell.showview2.downloadsLabel.text =appmodel.downloads;
            cell.showview2.commentLabel.text=[NSString stringWithFormat:@"%d",[appmodel.comment intValue]];
        }
        if (i==2) {
            cell.showview3.nameLabel.text=appmodel.name;
            [cell.showview3.starOverallStartView setStar:appmodel.starOverall.doubleValue];
            [cell.showview3.iconUrlImageView setImageWithURL:[NSURL URLWithString:appmodel.iconUrl]];
            cell.showview3.downloadsLabel.text =appmodel.downloads;
            cell.showview3.commentLabel.text=[NSString stringWithFormat:@"%d",[appmodel.comment intValue]];
        }
        if (i==3) {
            cell.showview4.nameLabel.text=appmodel.name;
            [cell.showview4.starOverallStartView setStar:appmodel.starOverall.doubleValue];
            [cell.showview4.iconUrlImageView setImageWithURL:[NSURL URLWithString:appmodel.iconUrl]];
            cell.showview4.downloadsLabel.text =appmodel.downloads;
            cell.showview4.commentLabel.text=[NSString stringWithFormat:@"%d",[appmodel.comment intValue]];
        }
    }
    return cell;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 308;
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
