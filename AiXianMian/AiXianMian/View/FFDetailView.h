//
//  FFDetailView.h
//  AiXianMian
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

//详情页面
@interface FFDetailView : UIView

@property (nonatomic, strong) UIImageView * imageViewIcon;

@property (nonatomic, strong) UILabel * labelName;

@property (nonatomic, strong) UILabel * labelLastPrice;

@property (nonatomic, strong) UILabel * labelFileSize;

@property (nonatomic, strong) UILabel * labelCategoryName;

@property (nonatomic, strong) UILabel * labelstarCurrent;

@property (nonatomic, strong) UIScrollView * scrollViewPhotos;

@property (nonatomic, strong) UILabel * labelDescription;

@property (nonatomic, strong) UIScrollView * scrollViewArround;

@property (nonatomic, strong) UIButton * btnShare;

@property (nonatomic, strong) UIButton * btnFavorites;

@property (nonatomic, strong) UIButton * btnDownload;

@end
