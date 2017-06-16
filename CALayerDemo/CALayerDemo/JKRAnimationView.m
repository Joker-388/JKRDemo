//
//  JKRAnimationView.m
//  CALayerDemo
//
//  Created by Lucky on 2017/6/15.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRAnimationView.h"

@implementation JKRAnimationView

+ (Class)layerClass {
    return [JKRLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(110, 110, 100, 100);
    self = [super initWithFrame:frame];
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [UIView animateWithDuration:3 animations:^{
//    }];
    self.backgroundColor = JKRRandomColor;
}

@end
