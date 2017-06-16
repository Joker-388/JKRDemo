//
//  JKRClockView.m
//  CALayerDemo
//
//  Created by Lucky on 2017/6/14.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRClockView.h"

@interface JKRClockView ()

@property (nonatomic, strong) CALayer *shi;
@property (nonatomic, strong) CALayer *fen;
@property (nonatomic, strong) CALayer *miao;

@end

@implementation JKRClockView

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, 100, 100);
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor lightGrayColor];
    [self.layer addSublayer:self.shi];
    [self.layer addSublayer:self.fen];
    [self.layer addSublayer:self.miao];
    [self startClock];
    return self;
}

- (void)startClock {
    @weakify(self);
    [NSTimer scheduledTimerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        @strongify(self);
        NSDate *now = [NSDate date];
        NSInteger hour = [now hour] > 12 ? ([now hour] - 12) : [now hour];
        NSInteger minute = [now minute];
        NSInteger second = [now second];
        self.shi.transform = CATransform3DMakeRotation(2 * M_PI * (hour / 12.0), 0, 0, 1);
        self.fen.transform = CATransform3DMakeRotation(2 * M_PI * (minute / 60.0), 0, 0, 1);
        self.miao.transform = CATransform3DMakeRotation(2 * M_PI * (second / 60.0), 0, 0, 1);
    }];
}

- (CALayer *)shi {
    if (!_shi) {
        _shi = [[CALayer alloc] init];
        _shi.backgroundColor = [UIColor redColor].CGColor;
        _shi.bounds = CGRectMake(0, 0, 3, 15);
        _shi.anchorPoint = CGPointMake(0.5, 1.0);
        _shi.position = self.center;
    }
    return _shi;
}

- (CALayer *)fen {
    if (!_fen) {
        _fen = [[CALayer alloc] init];
        _fen.bounds = CGRectMake(0, 0, 2, 25);
        _fen.anchorPoint = CGPointMake(0.5, 1.0);
        _fen.position = self.center;
        _fen.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _fen;
}

- (CALayer *)miao {
    if (!_miao) {
        _miao = [[CALayer alloc] init];
        _miao.bounds = CGRectMake(0, 0, 1, 35);
        _miao.anchorPoint = CGPointMake(0.5, 1.0);
        _miao.position = self.center;
        _miao.backgroundColor = [UIColor greenColor].CGColor;
    }
    return _miao;
}

@end
