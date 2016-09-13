//
//  ChatReceiverModel.h
//  FMDBDemo
//
//  Created by wangdemin on 16/9/13.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatReceiverModel : NSObject

//昵称
@property (nonatomic, copy) NSString *nickname;
//头像
@property (nonatomic, copy) NSString *avatar;
//电话
@property (nonatomic, copy) NSString *mobile;

@end
