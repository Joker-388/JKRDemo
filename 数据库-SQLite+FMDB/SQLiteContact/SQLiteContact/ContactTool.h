//
//  ContactTool.h
//  SQLiteContact
//
//  Created by Lucky on 15/9/1.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Contact;

@interface ContactTool : NSObject

//保存联系人
+ (void)saveContact:(Contact *)contact success:(void(^)())success failure:(void(^)(NSError *error))failure;

////搜索联系人 (C实现，框架方法代替)
//+ (void)execWithSQLiteString:(NSString *)string success:(void(^)())success failure:(void(^)(NSError *error))failure;

//获取全部联系人
+ (NSArray *)getAllContactsSuccess:(void(^)())success failure:(void(^)(NSError *error))failure;

//搜索联系人
+ (NSArray *)getContactsWithString:(NSString *)string success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
