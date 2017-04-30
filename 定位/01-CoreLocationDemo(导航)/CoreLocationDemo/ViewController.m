//
//  ViewController.m
//  CoreLocationDemo
//
//  Created by Lucky on 14/2/9.
//  Copyright (c) 2014年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *lmsg;

@property (nonatomic, strong) CLLocation *previousLocation;

@property (nonatomic, assign) CLLocationDistance sumDistance;

@property (nonatomic, assign) NSTimeInterval sumTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //CoreLocation基本使用
    
    //第一步，创建CoreLocation管理者
    //第二步，成为CoreLocation管理者的代理监听获取到的位置
    self.lmsg.delegate = self;
    
//    self.lmsg.distanceFilter = 100; //移动多少米获取一次位置
    
//    self.lmsg.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //精准度
    
    //iOS7只要开始定位，系统会自动请求用户获取授权，iOS8开始，必须自己主动要求用户受权
    //不仅仅要主动请求授权，还需要在info.plist中配置属性
    //NSLocationWhenInUseDescription 当前获取
    //NSLocationAlwaysUsageDescription 后台获取
    //判断是否是iOS8
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8) {
        NSLog(@"iOS8下主动请求授权");
        //主动要求用户对程序授权，授权成功后状态改变就会通知代理（在代理方法中获取授权后开始监听）
        [self.lmsg requestAlwaysAuthorization];
    }else{
        //第三步，开始监听（开始获取位置）
        [self.lmsg startUpdatingLocation]; //默认获取位置频率非常频繁
    }
    
}

#pragma mark - CLLocationManager代理方法

/**
 *  授权状态发生改变后调用
 *
 *  @param manager 触发事件对象
 *  @param status  当前授权的状态
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户未授权");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"无法使用定位服务");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"用户拒绝授权");
            break;
//        case kCLAuthorizationStatusAuthorized:
//            NSLog(@"已经授权（废弃）");
//            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"用户授权任何时刻都可以使用位置信息");
            [self.lmsg startUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"用户授权当前可以使用位置信息");
            [self.lmsg startUpdatingLocation];
            break;
        default:
            break;
    }
}

/**
 *  获取到位置信息之后就会调用
 *
 *  @param manager   触发事件的对象
 *  @param locations 获取到的位置
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%s", __func__);
//    [self.lmsg stopUpdatingLocation]; //获取到一次位置就停止再次获取
    
//    location.coordinate; 坐标, 包含经纬度, longitude经度, latitude, 纬度
//    location.altitude; 设备海拔高度 单位是米
//    location.course; 设置前进方向 0表示北 90东 180南 270西
//    location.horizontalAccuracy; 水平精准度
//    location.verticalAccuracy; 垂直精准度
//    location.timestamp; 定位信息返回的时间
//    location.speed; 设备移动速度 单位是米/秒, 适用于行车速度而不太适用于步行
    
    //导航当相关功能
    /**
     *  1，获取两次定位之间走了多远（当前位置 － 上一次位置）
     *  2，获取两次定位之间花了多长时间（当前时间 － 上一次时间）
     *  3，获取当前速度（两次定义之间的距离 ／ 两次等位花费的时间）
     *  4，获取总路程（把每两次定位的距离间隔累加）
     *  5，获取平均速度（总路程 ／ 总时间）
     */
    
    //当前位置
    CLLocation *currentLocation = [locations lastObject];
    
    if (self.previousLocation) {
        //两次定位之间的距离（单位：m）
        CLLocationDistance distance = [currentLocation distanceFromLocation:self.previousLocation];
        //两次定位之间的时间（单位：s）
        NSTimeInterval time = [currentLocation.timestamp timeIntervalSinceDate:self.previousLocation.timestamp];
        //两次定位之间的速度（m/s）
        CGFloat speed = distance / time;
        //累加路程
        self.sumDistance += distance;
        //累加时间
        self.sumTime += time;
        //平均速度
        CGFloat avgSpeed = self.sumDistance / self.sumTime;
        
        NSLog(@"路程：%f, 时间：%f, 速度：%f, 总路程：%f, 总时间：%f, 平均速度：%f", distance, time, speed, _sumDistance, _sumTime, avgSpeed);
        
        
    }
    self.previousLocation = currentLocation;
}

- (CLLocationManager *)lmsg
{
    if (!_lmsg) {
        _lmsg = [[CLLocationManager alloc] init];
    }
    return _lmsg;
}

@end
