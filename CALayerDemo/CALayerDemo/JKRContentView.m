//
//  JKRContentView.m
//  CALayerDemo
//
//  Created by Lucky on 2017/6/15.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRContentView.h"

@interface JKRContentView ()

@property (nonatomic, strong) CALayer *imageLayer;

@end

@implementation JKRContentView

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(110, 0, 100, 100);
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor lightGrayColor];
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
/**
    self.imageLayer.frame = CGRectMake(0, 0, 100, 100);
    self.imageLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.layer addSublayer:self.imageLayer];
    // 6M -> 6.5M
    // 100*3*100*3 * 4 / 1024 /1024 = 0.32;
 */
    self.imageLayer.frame = CGRectMake(0, 0, 100, 100);
    self.imageLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"image"].CGImage);
    [self.layer addSublayer:self.imageLayer];
    
    // 5.9M -> 7.3M = 1.4 M
    // bpp = 32
    // 800 * 800 * (32 / 8) / 1024 / 1024 = 2.4
}

- (CALayer *)imageLayer {
    if (!_imageLayer) {
        _imageLayer = [[CALayer alloc] init];
        
    }
    return _imageLayer;
}

@end
