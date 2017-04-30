//
//  ViewController.m
//  CoreLocationHeadDemo
//
//  Created by Lucky on 15/9/9.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *lmsg;

@property (nonatomic, strong) UIImageView *show;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *show = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_compasspointer"]];
    
    show.center = CGPointMake(self.view.center.x, self.view.center.y);
    
    [self.view addSubview:show];
    
    self.lmsg.delegate = self;
    
    [self.lmsg startUpdatingHeading];
    
    _show.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    _show = show;
}

#pragma mark - 代理方法

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    /**
     *  magneticHeading 设备与磁北的相对角度
     *  trueHeading 设置与真北的相对角度, 必须和定位一起使用, iOS需要设置的位置来计算真北
     *  真北始终指向地理北极点
     *  磁北对应随着时间变化的地球磁场北极
     */
//    NSLog(@"%s", __func__);
//    NSLog(@"%f", newHeading.magneticHeading);
    
    CGFloat angle = -newHeading.magneticHeading * M_PI / 180;
    
    self.show.layer.transform = CATransform3DMakeRotation(angle, 0 , 0 ,1);
    
}

- (CLLocationManager *)lmsg
{
    if (!_lmsg) {
        _lmsg = [[CLLocationManager alloc] init];
    }
    return _lmsg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
