//
//  ShowPhotosViewController.m
//  AiXianMian
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "ShowPhotosViewController.h"

@interface ShowPhotosViewController ()
{
    UIScrollView * _scrollView;
}
@end

@implementation ShowPhotosViewController

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
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _photos.count; i ++)
    {
        NSDictionary * dic = _photos[i];
        UIImageView * imageViewPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, 480)];
        [imageViewPhoto setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"originalUrl"]]];
        [_scrollView addSubview:imageViewPhoto];
    }
    _scrollView.contentSize = CGSizeMake(320 * _photos.count, 0);
    _scrollView.contentOffset = CGPointMake(320 * _index, 0);
    UIButton * btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(290, 450, 30, 30);
    btnBack.layer.cornerRadius = 15;
    [btnBack setBackgroundColor:[UIColor grayColor]];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:10];
    btnBack.showsTouchWhenHighlighted = YES;
    [btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
}

-(void)back:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
