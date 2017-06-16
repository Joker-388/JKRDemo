//
//  JKRLayer.m
//  CALayerDemo
//
//  Created by Lucky on 2017/6/15.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRLayer.h"

@implementation JKRLayer

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key {
    [super addAnimation:anim forKey:key];
}

/// layer发生改变的时候就会调用这个
- (id<CAAction>)actionForKey:(NSString *)event {
    id action = [super actionForKey:event];
    if (!action) {
        if ([event isEqualToString:@"backgroundColor"]) {
            CABasicAnimation *anim = [CABasicAnimation animation];
            anim.duration = 1;
            action = anim;
        }
    }
    return action;
}

+ (id<CAAction>)defaultActionForKey:(NSString *)event {
    id action = [CALayer defaultActionForKey:event];
    return action;
}

@end
