//
//  NSJoker.m
//  NSKeyedArchiverDemo
//
//  Created by Lucky on 15/9/24.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "JKRJoker.h"

@implementation JKRJoker

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt64:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.age = [aDecoder decodeInt64ForKey:@"age"];
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p>: {name: %@, age: %ld}", self.class, self, self.name, self.age];
}

@end
