//
//  FFTopicCell.h
//  AiXianMian
//
//  Created by qianfeng on 14-12-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFTopicCell : UITableViewCell

@property (nonatomic, strong) UILabel * labelTitle;

@property (nonatomic, strong) UIImageView * imageViewImg;

@property (nonatomic, strong) UIImageView * imageViewDesc;

@property (nonatomic, strong) UILabel * labelDesc;

@property (nonatomic, strong) NSMutableArray * arrAppShowView;

@end
