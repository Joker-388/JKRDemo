//
//  ViewController.m
//  MapKitDemo
//
//  Created by Lucky on 15/9/10.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "JKRAnnotation.h"
#import "JKRAnnotationView.h"

@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *lmsg;

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.显示类型
    //    MKMapTypeStandard = 0,
    //    MKMapTypeSatellite,
    //    MKMapTypeHybrid
    self.mapView.mapType = MKMapTypeStandard;
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        CLLocationManager *lmsg = [[CLLocationManager alloc] init];
        [lmsg requestAlwaysAuthorization];
        _lmsg = lmsg;
    }
    
    //2.跟踪用户位置
//    MKUserTrackingModeNone 不跟踪
//    MKUserTrackingModeFollow 跟踪并显示当前位置
//    MKUserTrackingModeFollowWithHeading 跟踪并显示当前位置，地图会跟随用户放心旋转
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
//    self.mapView.scrollEnabled = NO;
    
    self.mapView.delegate = self;
}

#pragma mark - MKMapView代理方法

/**
 *  每次更新用户位置会调用，调用并不频繁，只有用户位置改变才会调用
 *
 *  @param mapView      触发事件的对象
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //地图上蓝色的位置点就称为大头针
    //大头针可以拥有标题，子标题，位置信息
    //大头针显示什么内容由大头针模型确定
    
//    NSLog(@"获取到新位置");
    
    userLocation.title = @"Joker is here";
//    userLocation.subtitle = @"^-^";
    
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks lastObject];
        userLocation.subtitle = mark.locality;
    }];
    
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
    
    [self.mapView setRegion:region animated:YES];
}

/**
 *  地图区域改变完成后调用
 *
 *  @param mapView  触发事件的对象
 *  @param animated 是否用动画
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%f, %f", self.mapView.region.span.latitudeDelta, self.mapView.region.span.longitudeDelta);
}

/**
 *  每次添加大头针就会调用
 *
 *  @param mapView    触发事件的对象
 *  @param annotation 大头针模型
 *
 *  @return 大头针的View
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    NSLog(@"添加了大头针");
    
    //如果返回nil，系统会按照自己默认的方式显示
//    return nil;
    
    if (![annotation isKindOfClass:[JKRAnnotation class]]) {
        return nil;
    }
    
//    static NSString *identifier = @"mkCell";
//    
//    //*：默认情况下MKAnnotationView是无法显示的，如果想自定义大头针可以使用MKAnnotationView的子类MKPinAnnotationView
//    //*：默认情况下，大头针是不显示标题的
//    //*：如果使用MKPinAnnotationView创建的自定义大头针，设置大头针的图片是无效的
//    
//    //*：综上，如果是不修改大头针图片，只修改颜色用MKPinAnnotationView；如果修改大头针的图片，用MKAnnotationView
//    
//    //1，从缓存吃中取
////    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//    //2，如果缓存池中没有，创建一个新的
//    if (!annotationView) {
////        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
//        annotationView = [[MKAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
//        //大头针颜色
////        annotationView.pinColor = MKPinAnnotationColorPurple; //MKPinAnnotationView才有
//        //大头针是否有出现动画
////        annotationView.animatesDrop = YES; //MKPinAnnotationView才有
//        //大头针是否显示标题
//        annotationView.canShowCallout = YES;
//        //设置大头针点击后弹出的标题的偏移位置
////        annotationView.calloutOffset = CGPointMake(0, 0);
//        //设置大头针标题的左边辅助视图
//        annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
//        //设置大头针标题的左边辅助视图
//        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    }
//    //3，给大头针View设置数据
//    annotationView.annotation = annotation;
//    
//    JKRAnnotation *at = annotation;
//    
//    switch (at.type) {
//        case JKRAnnonationTypeAir:
//            annotationView.image = [UIImage imageNamed:@"category_4"];
//            break;
//        case JKRAnnonationTypeFood:
//            annotationView.image = [UIImage imageNamed:@"category_1"];
//            break;
//        case JKRAnnonationTypeHouse:
//            annotationView.image = [UIImage imageNamed:@"category_3"];
//            break;
//        case JKRAnnonationTypeKTV:
//            annotationView.image = [UIImage imageNamed:@"category_2"];
//            break;
//        case JKRAnnonationTypeMovie:
//            annotationView.image = [UIImage imageNamed:@"category_5"];
//            break;
//            
//        default:
//            break;
//    }
//
    
    JKRAnnotationView *annotationView = [JKRAnnotationView annotationViewWithMKMapView:mapView];
    
    annotationView.annotation = annotation;
    
    //4，返回大头针的View
    return annotationView;
}

- (IBAction)addAnnotation:(UIButton *)sender {
    
    JKRAnnotation *annotation = [[JKRAnnotation alloc] init];
    annotation.title = @"Joker";
    CGFloat latitude = 36.821199 + arc4random_uniform(20);
    CGFloat longitude = 116.858776 + arc4random_uniform(20);
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks lastObject];
        annotation.subtitle = mark.locality;
    }];
    
    annotation.coordinate = CLLocationCoordinate2DMake(latitude , longitude);
    
    annotation.type = arc4random() % 5;
    
    // 添加大头针
    [self.mapView addAnnotation:annotation];

}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

@end
