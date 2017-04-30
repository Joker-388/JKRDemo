//
//  ContactTool.m
//  SQLiteContact
//
//  Created by Lucky on 15/9/1.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ContactTool.h"
#import <sqlite3.h>
#import "Contact.h"
#import "FMDB.h"

@interface ContactTool()

@end

@implementation ContactTool

//static sqlite3 *_db;

static FMDatabase *_data;

+ (void)initialize
{
    //设置数据文件保存到哪里
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"contact.sqlite"];
//    sqlite3_open(dataPath.UTF8String, &_db);
//    NSString *sql = @"create table if not exists t_contact(id integer primary key autoincrement, name text, phone text);";
//    [self execWithSQLiteString:sql success:^{
//        
//    } failure:^(NSError *error) {
//        
//    }];
    FMDatabase *data = [FMDatabase databaseWithPath:dataPath];
    [data open];
    [data executeUpdate:@"create table if not exists t_contact(id integer primary key autoincrement, name text, phone text);"];
    _data = data;
}

+ (void)saveContact:(Contact *)contact success:(void (^)())success failure:(void (^)(NSError *))failure
{
//    NSString *sql = [NSString stringWithFormat:@"insert into t_contact (name, phone) values ('%@', '%@');", contact.name, contact.phone];
//    [self execWithSQLiteString:sql success:^{
//        success();
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    
    [_data executeUpdate:@"insert into t_contact (name, phone) values (?, ?);", contact.name, contact.phone];
}

//+ (void)execWithSQLiteString:(NSString *)string success:(void (^)())success failure:(void (^)(NSError *))failure
//{
//    char *errmsg;
//    sqlite3_exec(_db, string.UTF8String, NULL, NULL, &errmsg);
//    if (errmsg) {
//        NSString *str = [NSString stringWithFormat:@"%s", errmsg];
//        NSError *error = [[NSError alloc] initWithDomain:@"ContactTool" code:46 userInfo:@{@"reason" : str}];
//        failure(error);
//    }else{
//        success();
//    }
//    
//}

+ (NSArray *)getContactsWithString:(NSString *)string success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSString *str;
    if (string == nil) {
        str = [NSString stringWithFormat:@"select * from t_contact;"];
    }else{
        str = [NSString stringWithFormat:@"select * from t_contact where name like '%%%@%%' or phone like '%%%@%%';", string, string];
    }
//    NSLog(@"%@", str);
    NSMutableArray *contacts = [NSMutableArray array];
//    sqlite3_stmt *stmt;
//    if (sqlite3_prepare_v2(_db, str.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
//        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
//            NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
//            Contact *contact = [Contact contactWithName:name phone:phone];
//            [contacts addObject:contact];
//        }
//        success();
//    }else{
//        NSError *error = [[NSError alloc] initWithDomain:@"ContactTool" code:57 userInfo:@{@"reason" : @"sqlite3_prepare16_v2 failure"}];
//        failure(error);
//    }
//    return contacts;
    
    FMResultSet *resultSet = [_data executeQuery:str];
    while ([resultSet next]) {
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *phone = [resultSet stringForColumn:@"phone"];
        Contact *contact = [Contact contactWithName:name phone:phone];
        [contacts addObject:contact];
    }
    
    return contacts;
}

+ (NSArray *)getAllContactsSuccess:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSArray *contacts = [self getContactsWithString:nil success:^{
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
    return contacts;
}

@end
