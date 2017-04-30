//
//  JKRKeyChainTool.h
//  KeyChainDemo
//
//  Created by 陈星妤 on 16/6/2.
//  Copyright © 2016年 陈星妤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKRKeyChainTool : NSObject

+ (void)setObject:(nullable id)value forKey:(nonnull NSString *)key;

+ (void)setBool:(BOOL)value forKey:(nonnull NSString *)key;

+ (nullable id)objectForKey:(nonnull NSString *)key;

+ (BOOL)boolForKey:(nonnull NSString *)key;

+ (void)delegateValueForKey:(nonnull NSString *)key;

+ (nonnull NSString *)getUUID;

@end
