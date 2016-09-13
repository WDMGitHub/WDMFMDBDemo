//
//  ViewController.m
//  FMDBDemo
//
//  Created by wangdemin on 16/9/12.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "ViewController.h"
#import "DBTool.h"
#import "ChatReceiverModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChatReceiverModel *model = [[ChatReceiverModel alloc] init];
    model.nickname = @"唐老鸭";
    model.avatar = @"http";
    model.mobile = @"123456789";
    
    ChatReceiverModel *model2 = [[ChatReceiverModel alloc] init];
    model2.nickname = @"唐老鸭2";
    model2.avatar = @"http2";
    model2.mobile = @"1234567890";
    
    NSString *ID = @"messageid";
    NSString *databaseName = @"receiver";
    
    [DBTool createDatabase:databaseName];

    [DBTool createChatReceiverTableWithMessageID:ID];
    
    [DBTool insertChatReceiverTableWithMessageID:ID model:model];
    
    [DBTool insertChatReceiverTableWithMessageID:ID model:model2];
    
//    [DBTool deleteChatReceiverTableWithMessageID:ID model:model];

//    [DBTool deleteAllChatReceiverTableWithMessageID:ID];
    
//    [DBTool updateChatReceiverTableWithMessageID:ID model:model2];
    
    NSArray *array = [DBTool getChatReceiverTableWithMessageID:ID];
    NSLog(@"%@", array);
    //关闭数据库
    [DBTool closeDatabase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
