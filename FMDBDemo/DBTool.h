//
//  DBTool.h
//  FMDBDemo
//
//  Created by wangdemin on 16/9/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatReceiverModel;

@interface DBTool : NSObject

//创建数据库
+ (void)createDatabase:(NSString *)databaseName;
//关闭数据库
+ (void)closeDatabase;
//创建聊天接受者列表
+ (void)createChatReceiverTableWithMessageID:(NSString *)ID;
//插入聊天接受者
+ (void)insertChatReceiverTableWithMessageID:(NSString *)ID model:(ChatReceiverModel *)model;
//删除聊天接受者
+ (void)deleteChatReceiverTableWithMessageID:(NSString *)ID model:(ChatReceiverModel *)model;
//删除所有聊天接受者列表
+ (void)deleteAllChatReceiverTableWithMessageID:(NSString *)ID;
//更新聊天接受者列表
+ (void)updateChatReceiverTableWithMessageID:(NSString *)ID model:(ChatReceiverModel *)model;
//获取聊天接受者列表
+ (NSArray *)getChatReceiverTableWithMessageID:(NSString *)ID;

@end
