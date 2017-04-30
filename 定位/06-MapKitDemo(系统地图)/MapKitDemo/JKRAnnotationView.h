//
//  JKRAnnotationView.h
//  MapKitDemo
//
//  Created by Lucky on 15/9/10.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "JKRAnnotation.h"

@interface JKRAnnotationView : MKAnnotationView

+ (instancetype)annotationViewWithMKMapView:(MKMapView *)mapView;

@end
