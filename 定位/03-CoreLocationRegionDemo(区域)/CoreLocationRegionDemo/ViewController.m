//
//  ViewController.m
//  CoreLocationRegionDemo
//
//  Created by Lucky on 15/9/10.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *lmsg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lmsg.delegate = self;
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(22.540927, 113.979165);
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:500 identifier:@"世界之窗"];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8) {
        [self.lmsg requestAlwaysAuthorization];
    }else{
        [self.lmsg startMonitoringForRegion:region];
    }
    
    
    
}

- (void)locationManager:(nonnull CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(22.540927, 113.979165);
        
        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:500 identifier:@"世界之窗"];
        
        [self.lmsg startMonitoringForRegion:region];
    }
}

- (void)locationManager:(nonnull CLLocationManager *)manager didEnterRegion:(nonnull CLRegion *)region
{
    NSLog(@"进入监听区域");
}

- (void)locationManager:(nonnull CLLocationManager *)manager didExitRegion:(nonnull CLRegion *)region
{
    NSLog(@"退出监听区域");
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
