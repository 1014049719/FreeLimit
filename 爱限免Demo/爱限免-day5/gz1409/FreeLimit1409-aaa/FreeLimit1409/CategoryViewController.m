//
//  CategoryViewController.m
//  FreeLimit1409
//
//  Created by mac on 14-11-28.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "CategoryViewController.h"

#import "CategoryModel.h"

#import "CategoryCell.h"

@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ZJHttpRequest *_httpRequest;
    NSMutableArray *_dataArray;
    
    UITableView *_tableView;
    
    void(^_action) (NSString *categoryID);
    
}
@end

@implementation CategoryViewController


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
    
    //设置导航条
    [self configNavigation];
    
    //下载分类数据
    _dataArray = [[NSMutableArray alloc] init];
    [self downloadData];
    
    //创建表格视图
    [self createTableView];
}


#pragma mark - 改变分类

-(void)setChangeCategoryAction:( void(^) (NSString *categoryID) )action;
{
    _action = action;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryModel *model = _dataArray[indexPath.row];
    if(_action)
    {
        _action(model.category_id);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 表格视图
-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[CategoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    CategoryModel *model = _dataArray[indexPath.row];
    //设置cell
    cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"category_%@.jpg",model.category_name]];
    cell.nameLabel.text = model.category_cname;
    cell.detailLabel.text = [NSString stringWithFormat:@"共%@款应用,其中限免%@款",model.category_count,model.limited];
    
    
    //别忘了reloadData
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

#pragma mark - 下载数据

-(void)downloadData
{
    _httpRequest = [[ZJHttpRequest alloc] initWithURLString:CATE_URL success:^(NSData *data)
    {
        NSArray *categoryArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dict in categoryArray) {
            //[self createModelWithDictionary:dict modeName:@"CategoryModel"];
            
            CategoryModel *model = [[CategoryModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            
            //遇到错误: setValue:forUndefinedKey:
            //原因: 字典中有些key在对象没有对应的属性
            //      自动引发异常
            //解决:  重写model的setValue:forUndefinedKey:
            [_dataArray addObject:model];
            
        }
        [_tableView reloadData];
    }];
    
    //ZJBlockTableView ---
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

#pragma mark - 导航条设置
-(void)configNavigation
{
    self.title = @"限 免 分 类";
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
