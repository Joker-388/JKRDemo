//
//  JKRMaskView.m
//  CALayerDemo
//
//  Created by Lucky on 2017/6/15.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRMaskView.h"

@implementation JKRMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 110, 100, 100);
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor lightGrayColor];
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"image"].CGImage);
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}

@end
