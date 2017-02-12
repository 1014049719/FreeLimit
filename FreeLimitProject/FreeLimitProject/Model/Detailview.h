//
//  Detailview.h
//  FreeLimitProject
//
//  Created by qianfeng on 15-1-5.
//  Copyright (c) 2015年 hubei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detailview : UIView

@property (strong,nonatomic)UIImageView *imageViewIcon;
@property (strong,nonatomic)UILabel *labelName;
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
