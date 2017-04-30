//
//  JKRPerson.m
//  PlistDemo
//
//  Created by Lucky on 15/9/24.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "JKRPerson.h"

@implementation JKRPerson

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    return self;
}

@end
