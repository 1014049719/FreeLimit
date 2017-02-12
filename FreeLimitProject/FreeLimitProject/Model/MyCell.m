//
//  MyCell.m
//  FreeLimitProject
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self createCell];
    }
    return self;
}
-(void)createCell{

    //cell背景
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageview.image=[UIImage imageNamed:@"cate_list_bg2.png"];
    self.backgroundView=imageview;
    
    self.iconview=[[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 60, 60)];
    [self.contentView addSubview:self.iconview];
    
    self.namelable=[[UILabel alloc] initWithFrame:CGRectMake(80 ,8 ,200 ,30 )];
    [self.contentView addSubview:self.namelable];
    
    self.pricelable=[[UILabel alloc] initWithFrame:CGRectMake(220, 22, 100, 30)];
    [self.contentView addSubview:self.pricelable];
    
    self.categorylable=[[UILabel alloc] initWithFrame:CGRectMake(220,45 , 100, 30)];
    [self.contentView addSubview:self.categorylable];
    
    self.sharelable=[[UILabel alloc] initWithFrame:CGRectMake(15, 70,100 , 30)];
    [self.contentView addSubview:self.sharelable];
    
    self.collectlable=[[UILabel alloc] initWithFrame:CGRectMake(110,70 ,100 , 30)];
    [self.contentView addSubview:self.collectlable];
    
    self.downloadlable=[[UILabel alloc] initWithFrame:CGRectMake(210,70 , 100,30 )];
    [self.contentView addSubview:self.downloadlable];
    
    self.starimageview=[[StarView alloc] initWithFrame:CGRectMake(80, 38, 100, 30)];
    [self.contentView addSubview:self.starimageview];
    

}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
