//
//  MapViewViewController.m
//  MKDirectionsDemo(获取导航路线信息)
//
//  Created by Lucky on 15/9/11.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "MapViewViewController.h"
#import "JKRAnnotation.h"

@interface MapViewViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mapView.delegate = self;
    
    [self addOverlay];
    
    [self addAnnotation];
    
    [self scrollMapToSource];
    
}

/**
 *  绘制路径
 */
- (void)addOverlay
{
    NSArray *routes = _response.routes;
    
    for (MKRoute *route in routes) {
        
        [self.mapView addOverlay:route.polyline];
        
    }
}

/**
 *  添加大头针
 */
- (void)addAnnotation
{
    JKRAnnotation *startAnnotation = [[JKRAnnotation alloc] init];
    
    NSArray *startAddressArr = _response.source.placemark.addressDictionary[@"FormattedAddressLines"];
    
    NSMutableString *startAddressStr = [NSMutableString string];
    for (NSString *str in startAddressArr) {
        [startAddressStr appendString:str];
    }
    
    startAnnotation.subtitle = startAddressStr;
    
    startAnnotation.title = _response.source.name;
    
    startAnnotation.coordinate = _response.source.placemark.coordinate;
    
    startAnnotation.type = JKRAnnotationTypeSource;
    
    [self.mapView addAnnotation:startAnnotation];
    
    JKRAnnotation *endAnnotation = [[JKRAnnotation alloc] init];
    
    NSArray *endAddressArr = _response.destination.placemark.addressDictionary[@"FormattedAddressLines"];
    
    NSMutableString *endAddressStr = [NSMutableString string];
    for (NSString *str in endAddressArr) {
        [endAddressStr appendString:str];
    }
    
    endAnnotation.subtitle = endAddressStr;
    
    endAnnotation.title = _response.destination.name;
    
    endAnnotation.coordinate = _response.destination.placemark.coordinate;
    
    endAnnotation.type = JKRAnnotationTypeDestination;
    
    [self.mapView addAnnotation:endAnnotation];
}

/**
 *  移动视角到起点
 */
- (void)scrollMapToSource
{
    CLLocationCoordinate2D startCoordinate = _response.source.placemark.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMake(startCoordinate, MKCoordinateSpanMake(0.1, 0.1));
    
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - 代理方法

/**
 *  添加线条会调用＊自定义添加必须重定义线条，否则不显示
 */

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *line = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    line.lineWidth = 3;
    
    line.strokeColor = [UIColor grayColor];
    
    return line;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[JKRAnnotation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"mkCell";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    }
    
    JKRAnnotation *at = annotation;
    
    if (at.type == JKRAnnotationTypeSource) {
        annotationView.pinColor = MKPinAnnotationColorGreen;
    }else{
        annotationView.pinColor = MKPinAnnotationColorRed;
    }
    
    
    annotationView.annotation = annotation;
    
    return annotationView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
