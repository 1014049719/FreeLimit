//
//  MyFavoriteViewController.m
//  FreeLimit1409
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "MyFavoriteViewController.h"

#import "DatabaseManager.h"


@interface MyFavoriteViewController ()

@end

@implementation MyFavoriteViewController

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
    
    [self createUI];
}

-(void)createUI
{
    self.view.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
    
    
    self.title = @"我 的 收 藏";
    NSArray *array = [[DatabaseManager sharedInstance] recordsWithRecordType:RecordTypeFavorite];
    double w = 60;
    double h = 60;
    double x = 45;
    double y = 45;
    double interval = 20;
    for (int i=0; i<array.count; i++) {
        AppModel *model = array[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [imageView setImageWithURL:[NSURL URLWithString:model.iconUrl]];
        imageView.layer.cornerRadius = 10;
        imageView.clipsToBounds = YES;
        [self.view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y + 45, w, h)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = model.name;
        label.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:label];
        
        //改变坐标
        i%3 != 2?(x+=(w+interval)):(x=45,y+=(h+interval));
    }
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
