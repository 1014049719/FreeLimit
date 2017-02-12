//
//  NetInterface.h
//  FreeLimitProject
//
//  Created by 胡贝 on 14/12/23.
//  Copyright (c) 2014年 hubei. All rights reserved.
//

#ifndef FreeLimitProject_NetInterface_h
#define FreeLimitProject_NetInterface_h

//限免页面接口
//http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=1&category_id=6014&timestamp=20140410085308&sign=XXXXXXXXXXXXXXXX
#define LIMIT_URL @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=%d&category_id=%@"

//降价页面接口
//http://iappfree.candou.com:8080/free/applications/sales?currency=rmb&page=1&category_id=6014
#define SALE_URL @"http://iappfree.candou.com:8080/free/applications/sales?currency=rmb&page=%d&category_id=%@"

//免费页面接口
//http://iappfree.candou.com:8080/free/applications/free?currency=rmb&page=1&category_id=6014
#define FREE_URL @"http://iappfree.candou.com:8080/free/applications/free?currency=rmb&page=%d&category_id=%@"

//专题界面接口
//http://iappfree.candou.com:8080/free/special?page=1&limit=5
#define TOPIC_URL @"http://iappfree.candou.com:8080/free/special?page=%d&limit=5"

//热榜页面接口
//http://open.candou.com/mobile/hot/page/1&category_id=6014
#define HOT_URL @"http://open.candou.com/mobile/hot/page/%d&category_id=%@"


//分类界面接口
//http://open.candou.com/app/count
#define CATE_URL @"http://open.candou.com/app/count"

/*
 {
 "category": [
 {
 "categoryId": "6000",
 "categoryName": "Business",
 "count": "1066",
 "lessenPrice": "57443"
 },
 {
 "categoryId": "6001",
 "categoryName": "Weather",
 "count": "198",
 "lessenPrice": "1837"
 },
 */



//详情页面接口
// http://iappfree.candou.com:8080/free/applications/688743207?currency=rmb
#define DETAIL_URL @"http://iappfree.candou.com:8080/free/applications/%d?currency=rmb"

//周边使用应用接口:
//http://iappfree.candou.com:8080/free/applications/recommend?longitude=116.344539&latitude=40.034346
//参数longitude,latitude填写经度和纬度。
#define NEARBY_APP_URL @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=%lf&latitude=%lf"

//搜索界面接口
// http://open.candou.com/search/app/word/app/app/iphone/rank/0/start/1/limit/40
#define SEARCH_URL @"http://open.candou.com/search/app/word/%@/app/iphone/rank/0/start/1/limit/40"

//蚕豆推荐应用接口
//http://open.candou.com/mobile/candou
#define CANDOU_URL @"http://open.candou.com/mobile/candou"

//配置界面-我的账户接口
//http://iappfree.candou.com:8080/free/categories/limited
#define MYUSER_URL @"http://iappfree.candou.com:8080/free/categories/limited"

#endif
