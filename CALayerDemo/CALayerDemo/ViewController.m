//
//  ViewController.m
//  CALayerDemo
//
//  Created by Lucky on 2017/6/14.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import "JKRClockView.h"
#import "JKRContentView.h"
#import "JKRMaskView.h"
#import "JKRAnimationView.h"

#import "JKRLayer.h"

@interface ViewController ()

@property (nonatomic, strong) JKRLayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:[JKRClockView new]];
    [self.view addSubview:[JKRContentView new]];
    [self.view addSubview:[JKRMaskView new]];
    [self.view addSubview:[JKRAnimationView new]];
    
    self.layer = [JKRLayer layer];
    self.layer.frame = CGRectMake(0, 300, 100, 100);
    [self.view.layer addSublayer:self.layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.layer.backgroundColor = JKRRandomColor.CGColor;
}

@end
