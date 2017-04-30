//
//  ViewController.m
//  MKMapItemDemo
//
//  Created by Lucky on 15/9/11.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@property (nonatomic, strong) CLGeocoder *geocoder;

- (IBAction)startNavigation;
/**
 *  开始位置
 */
@property (weak, nonatomic) IBOutlet UITextField *startField;
/**
 *  结束位置
 */
@property (weak, nonatomic) IBOutlet UITextField *endField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)startNavigation
{
    if (self.startField.text == nil && self.startField.text.length == 0 && self.endField.text == nil && self.endField.text.length == 0) {
        return;
    }
    
    //先用地理编码获取到地理信息
    
    [self.geocoder geocodeAddressString:self.startField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *startMark = [placemarks firstObject];
        
        [self.geocoder geocodeAddressString:self.endField.text completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *endMark = [placemarks firstObject];
            
            //利用返回的placeMark创建MKMapItem对象
            
            MKPlacemark *startMKMark = [[MKPlacemark alloc] initWithPlacemark:startMark];
            
            MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startMKMark];
            
            MKPlacemark *endMKMark = [[MKPlacemark alloc] initWithPlacemark:endMark];
            
            MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endMKMark];
            
            //打开导航
            [self startMKMapItemWithStartMKMapItem:startItem endMKMapItem:endItem];
        }];
        
    }];
}

- (void)startMKMapItemWithStartMKMapItem:(MKMapItem *)startItem endMKMapItem:(MKMapItem *)endItem;
{
    //数组包装起点和终点
    NSArray *items = @[startItem, endItem];
    
    //设置导航界面
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    
    options[MKLaunchOptionsMapTypeKey] = @0;
    
    //打开导航
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

@end
