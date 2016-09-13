//
//  DBTool.m
//  FMDBDemo
//
//  Created by wangdemin on 16/9/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "DBTool.h"
#import "FMDatabase.h"
#import "ChatReceiverModel.h"

FMDatabase *__db = nil;
@implementation DBTool

//创建数据库
+ (void)createDatabase:(NSString *)databaseName
{
    NSString *dbpath = [NSString stringWithFormat:@"Documents/%@.sqlite", databaseName];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:dbpath];
    NSLog(@"DB Path: %@", NSHomeDirectory());
    
    if (!__db)
    {
        //创建FMDB并设置数据库文件路径
        __db = [[FMDatabase alloc] initWithPath:path];
        NSLog(@"数据库创建成功");
    }
    else
    {
        NSLog(@"数据库打开成功");
    }
    NSLog(@"DB name: %@", databaseName);
    //打开数据库文件 （如果文件不存在，就创建新文件并打开）
    [__db open];
}

//关闭数据库
+ (void)closeDatabase
{
    if ([__db close])
    {
        __db = nil;
        NSLog(@"关闭成功");
    }
    else
    {
        NSLog(@"关闭失败");
    }
}

//创建聊天接受者列表
+ (void)createChatReceiverTableWithMessageID:(NSString *)ID
{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS ChatReceiverTable_%@(chatID INTEGER PRIMARY KEY AUTOINCREMENT, nickname TEXT, avatar TEXT, mobile TEXT)", ID];
    if ([__db executeUpdate:sql])
    {
        NSLog(@"创建表成功");
    }
    else
    {
        NSLog(@"创建表失败");
    }
}

//插入聊天接受者
+ (void)insertChatReceiverTableWithMessageID:(NSString *)ID model:(ChatReceiverModel *)model
{
    NSString *nickname = model.nickname;
    NSString *avatar = model.avatar;
    NSString *mobile = model.mobile;
    NSString *sql = [NSString stringWithFormat:@"REPLACE INTO ChatReceiverTable_%@(nickname, avatar, mobile) VALUES('%@', '%@', '%@')", ID, nickname, avatar, mobile];
    
    NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM ChatReceiverTable_%@ WHERE mobile = %@", ID, mobile];
    FMResultSet *set = [__db executeQuery:selectSql];
    if (![set next])
    {
        if ([__db executeUpdate:sql])
        {
            NSLog(@"%@插入表成功", ID);
        }
        else
        {
            NSLog(@"%@插入表失败", ID);
        }
    }
    else
    {
        NSLog(@"mobile__%@__已存在", mobile);
    }
}

//删除聊天接受者
+ (void)deleteChatReceiverTableWithMessageID:(NSString *)ID model:(ChatReceiverModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM ChatReceiverTable_%@ WHERE nickname = '%@'", ID, model.nickname];
    if ([__db executeUpdate:sql])
    {
        NSLog(@"删除nickname为%@的聊天接受者成功", model.nickname);
    }
    else
    {
        NSLog(@"删除nickname为%@的聊天接受者失败", model.nickname);
    }
}

//删除所有聊天接受者列表
+ (void)deleteAllChatReceiverTableWithMessageID:(NSString *)ID
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM ChatReceiverTable_%@", ID];
    if ([__db executeUpdate:sql])
    {
        NSLog(@"删除聊天接受者列表成功");
    }
    else
    {
        NSLog(@"删除聊天接受者列表失败");
    }
}

//更新聊天接受者列表
+ (void)updateChatReceiverTableWithMessageID:(NSString *)ID model:(ChatReceiverModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE ChatReceiverTable_%@ SET nickname = '%@', avatar = '%@' WHERE  mobile = '%@'", ID, model.nickname, model.avatar, model.mobile];
    if ([__db executeUpdate:sql])
    {
        NSLog(@"更新表成功");
    }
    else
    {
        NSLog(@"更新表失败");
    }
}

//获取聊天接受者列表
+ (NSArray *)getChatReceiverTableWithMessageID:(NSString *)ID
{
    NSMutableArray *array = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ChatReceiverTable_%@", ID];
    FMResultSet *set = [__db executeQuery:sql];
    
    while ([set next])
    {
        NSDictionary *dic = @{@"nickname":[set stringForColumn:@"nickname"],
                              @"avatar":[set stringForColumn:@"avatar"],
                              @"mobile":[set stringForColumn:@"mobile"]
                              };
        [array addObject:dic];
    }
    return array;
}

@end
