//
//  TopicCell.h
//  LoveFree
//
//  Created by qianfeng on 14-12-29.
//  Copyright (c) 2014年 syc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppShowView;
@interface TopicCell : UITableViewCell

//"title": "和《星你》一起玩星星游戏",
//"date": "2014-02-26",
//"img": "http://special.candou.com/fc3b85d07e093e01da1fc5354c0fe50a.jpg",
//"desc_img": "http://special.candou.com/bc02eddd7785db5cf48087b8cac06d51.jpg",
//"desc": "小编mm推荐：追韩剧当然不能忘了玩游戏，各色星星都已在此，你准备好了啤酒和炸鸡了么？",
//"applications": [
//                 {
//                     "applicationId": "557137623",
//                     "name": "愤怒的小鸟:星球大战",
//                     "iconUrl": "http://photo.candou.com/i/114/ede69d55271a82d513b9aee4c0eb0a44",
//                     "starOverall": "4.5",
//                     "ratingOverall": "0",
//                     "downloads": "1079",
//                     "comment": 0
//                 },

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * imgImageView;
@property (nonatomic, strong) UIImageView * desc_imgImageView;
@property (nonatomic, strong) UILabel * descLabel;

@property (nonatomic, strong) AppShowView * appShowView1;
@property (nonatomic, strong) AppShowView * appShowView2;
@property (nonatomic, strong) AppShowView * appShowView3;
@property (nonatomic, strong) AppShowView * appShowView4;

@end
