//
//  TopicCell.m
//  FreeLimit1409
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "TopicCell.h"

@interface TopicCell ()
{
    void (^_action)(TopicAppView *view, AppModel *model);
}
@end

@implementation TopicCell

//添加block回调
//作用: block定义在viewControler, 能拿到导航控制器
-(void) setAppViewAction:( void (^)(TopicAppView *view, AppModel *model) )action
{
    _action = action;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    /*
     界面描述
     //TopicCell - cell大小 310X308
     背景		topic_Cell_Bg.png
     _titleLabel 		10, 15, 320, 30 font=18
     _imgView 				10, 50, 122, 186
     appShowViewArray--4个
     double w=160;
     double h=50;
     double x=140;
     y = 50 + i*h;
     _imgDescView		10, 260, 40, 40
     _descLabel 		60, 260, 240, 40   font=12
     */
    
    //320 * 308
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 308)];
    backView.image = [UIImage imageNamed:@"topic_Cell_Bg.png"];
    [self.contentView addSubview:backView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 320, 30)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLabel];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 122, 186)];
    [self.contentView addSubview:_iconImageView];
    
    _descImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 260, 40, 40)];
    [self.contentView addSubview:_descImageView];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 250, 240, 60)];
    _descLabel.font = [UIFont systemFontOfSize:12];
    _descLabel.numberOfLines = 3;
    [self.contentView addSubview:_descLabel];
    
    
    //cell上创建4个appView
    _appViewArray = [[NSMutableArray alloc] init];
    for (int i=0; i<4; i++) {
        double w=160;
        double h=50;
        double x=140;
        double y = 50 + i*h;
        
        TopicAppView *appView = [[TopicAppView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [self.contentView addSubview:appView];
        [_appViewArray addObject:appView];
        
        //问题1: 如何拿到导航控制器
        //问题2: 如何难道view 对应 model
        
        //添加点击处理
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
        [appView addGestureRecognizer:tap];
    }
}

-(void)dealTap:(UITapGestureRecognizer *)tap
{
    if(_action)
    {
        TopicAppView *appView = (TopicAppView *)tap.view;
        _action(appView,appView.model);
    }
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
