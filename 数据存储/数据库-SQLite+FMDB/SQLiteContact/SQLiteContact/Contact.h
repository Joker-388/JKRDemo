//
//  Contact.h
//  SQLiteContact
//
//  Created by Lucky on 15/9/1.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phone;

+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone;

@end
