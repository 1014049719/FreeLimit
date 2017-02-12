//
//  DatabaseManager.m
//  FreeLimit1409
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 zhang jian. All rights reserved.
//

#import "DatabaseManager.h"

#import "FMDatabase.h"

@interface DatabaseManager ()
{
    FMDatabase *_database;
}
@end

@implementation DatabaseManager
//需要在多个界面同时操作数据库,设计成单例
//  完成初始化操作
+(id)sharedInstance
{
    static DatabaseManager *dm = nil;
    if(dm == nil)
    {
        dm = [[DatabaseManager alloc] init];
    }
    return dm;
}
-(id)init
{
    if(self = [super init])
    {
        //初始化数据库
        [self configDataBase];
    }
    return self;
}
-(void)configDataBase
{
    //创建数据库
    NSString *path = [NSString stringWithFormat:@"%@/Documents/app.data",NSHomeDirectory()];
    _database = [[FMDatabase alloc] initWithPath:path];
    if(_database.open == NO)
    {
        NSLog(@"数据库初始化失败");
        return;
    }
    
    //创建表格
    NSString *sql = @"create table if not exists applist  ("
    " id integer primary key autoincrement not null, "
    " recordType varchar(32), "
    " applicationId integer not null, "
    " name varchar(128), "
    " iconUrl varchar(1024), "
    " type varchar(32) ,"
    " lastPrice integer, "
    " currentPrice integer "
    " );";;
    BOOL b = [_database executeUpdate:sql];
    if(!b)
    {
        NSLog(@"数据创建失败");
    }
}
//添加一条记录, 第二个参数是记录类型
-(void)addRecordWithAppModel:(AppModel *)model recordType:(RecordType)recordType
{
    //判断,如果已经存在, 则不添加
    if([self isExistRecordWithAppModel:model
 recordType:recordType])
    {
        return;
    }
    
    
    NSString *sql = @"INSERT INTO applist(recordType,applicationId,name,iconUrl,type,lastPrice,currentPrice) VALUES(?,?,?,?,?,?,?);";
    BOOL b = [_database executeUpdate:sql,[NSString stringWithFormat:@"%d",recordType],model.applicationId,model.name,model.iconUrl,@"limit",model.lastPrice,model.currentPrice];
    if(!b)
    {
        NSLog(@"插入失败");
    }
}
//判断有没有某个应用某种类型的记录
-(BOOL)isExistRecordWithAppModel:(AppModel *)model recordType:(RecordType)recordType{
    NSString *sql = @"SELECT count(*) FROM applist WHERE applicationId = ? AND recordType = ?;";
    FMResultSet *result = [_database executeQuery:sql,model.applicationId,[NSString stringWithFormat:@"%d",recordType]];
    while ([result next]) {
        int count = [[result stringForColumnIndex:0] intValue];
        if(count > 0)
        {
            return YES;
         
        }
    }
    return NO;
}
//删除一条记录, 第二个参数是记录类型
-(void)removeRecordWithAppModel:(AppModel *)model recordType:(RecordType)recordType
{
    NSString *sql = @"DELETE FROM applist WHERE applicationId = ? AND recordType = ?;";
    BOOL b = [_database executeUpdate:sql,model.applicationId,[NSString stringWithFormat:@"%d",recordType]];
    if(!b)
    {
        NSLog(@"删除失败");
    }
}
//获取某种类型的应用
-(NSArray *)recordsWithRecordType:(RecordType)recordType
{
    NSString *sql = @"SELECT * FROM applist WHERE recordType = ?;";
    FMResultSet *result = [_database executeQuery:sql,[NSString stringWithFormat:@"%d",recordType]];
    NSMutableArray *marr = [[NSMutableArray alloc] init];
    while ([result next]) {
        AppModel *model = [[AppModel alloc] init];
        model.applicationId = [result stringForColumn:@"applicationId"];
        model.name = [result stringForColumn:@"name"];
        model.iconUrl = [result stringForColumn:@"iconUrl"];
        model.lastPrice = [result stringForColumn:@"lastPrice"];
        model.currentPrice = [result stringForColumn:@"currentPrice"];
        [marr addObject:model];
    }
    return marr;
}
@end
