//
//  LimitFreeCell.h
//  LoveFree
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import <UIKit/UIKit.h>

//"applicationId": "455680974",
//"slug": "rhythm-repeat",
//"name": "节奏重复",
//"releaseDate": "2014-07-01",
//"version": "2.3",
//"description": "界面清新简单的音乐节奏游戏。游戏的操作非常简单，只需根据提示依次点击相应的图标即可，共有三种乐曲选择。",
//"categoryId": 6014,
//"categoryName": "Game",
//"iconUrl": "http://photo.candou.com/i/114/55b07f3725eae8b3cafc9bce10d16e46",
//"itunesUrl": "http://itunes.apple.com/cn/app/rhythm-repeat/id455680974?mt=8",
//"starCurrent": "4.0",
//"starOverall": "4.0",
//"ratingOverall": "0",
//"downloads": "2769",
//"currentPrice": "0",
//"lastPrice": "12",
//"priceTrend": "limited",
//"expireDatetime": "2014-12-26 23:31:20.0",
//"releaseNotes": "Multi-Touch bug fixed",
//"updateDate": "2014-10-17 15:45:27",
//"fileSize": "16.69",
//"ipa": "1",
//"shares": "165",
//"favorites": "104"

@class StarView;
@interface LimitFreeCell : UITableViewCell

@property (nonatomic, strong) UIImageView * iconUrlImageView;
@property (nonatomic, strong) StarView * starCurrentStarView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * lastPriceLabel;
@property (nonatomic, strong) UILabel * categoryNameLabel;
@property (nonatomic, strong) UILabel * sharesLabel;
@property (nonatomic, strong) UILabel * favoritesLabel;
@property (nonatomic, strong) UILabel * downloadsLabel;

@end
