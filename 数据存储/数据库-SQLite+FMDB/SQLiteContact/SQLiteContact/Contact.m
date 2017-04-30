//
//  Contact.m
//  SQLiteContact
//
//  Created by Lucky on 15/9/1.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "Contact.h"

@implementation Contact

+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone
{
    Contact *contact = [[self alloc] init];
    
    contact.name = name;
    contact.phone = phone;
    
    return contact;
}

@end
