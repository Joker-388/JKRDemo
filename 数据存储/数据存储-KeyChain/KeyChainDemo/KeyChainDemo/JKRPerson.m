//
//  JKRPerson.m
//  KeyChainDemo
//
//  Created by Lucky on 2017/4/16.
//  Copyright © 2017年 陈星妤. All rights reserved.
//

#import "JKRPerson.h"

@implementation JKRPerson

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    return self;
}

@end
