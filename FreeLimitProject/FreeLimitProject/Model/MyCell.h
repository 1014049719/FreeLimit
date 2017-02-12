//
//  MyCell.h
//  FreeLimitProject
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface MyCell : UITableViewCell

@property (strong,nonatomic)UIImageView *iconview;
@property (strong,nonatomic)UILabel *namelable;
@property (strong,nonatomic)UILabel *pricelable;
@property (strong,nonatomic)UILabel *categorylable;
@property (strong,nonatomic)UILabel *sharelable;
@property (strong,nonatomic)UILabel *collectlable;
@property (strong,nonatomic)UILabel *downloadlable;
@property (strong,nonatomic)StarView *starimageview;

@end
