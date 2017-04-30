//
//  JKRAnnotationView.m
//  MapKitDemo
//
//  Created by Lucky on 15/9/10.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import "JKRAnnotationView.h"

@implementation JKRAnnotationView

+ (instancetype)annotationViewWithMKMapView:(MKMapView *)mapView
{
    static NSString *cid = @"cell";
    
    //大头针重用
    JKRAnnotationView *annotationView = (JKRAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:cid];
    
    //缓存池没有的时候新建
    if (!annotationView) {
        annotationView = [[JKRAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:cid];
    }

    return annotationView;
}

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.canShowCallout = YES;
        //大头针左右视图
        self.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
        self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    }
    
    return self;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    
    JKRAnnotation *at = annotation;
    
    switch (at.type) {
        case JKRAnnonationTypeAir:
            self.image = [UIImage imageNamed:@"category_4"];
            break;
        case JKRAnnonationTypeFood:
            self.image = [UIImage imageNamed:@"category_1"];
            break;
        case JKRAnnonationTypeHouse:
            self.image = [UIImage imageNamed:@"category_3"];
            break;
        case JKRAnnonationTypeKTV:
            self.image = [UIImage imageNamed:@"category_2"];
            break;
        case JKRAnnonationTypeMovie:
            self.image = [UIImage imageNamed:@"category_5"];
            break;
            
        default:
            break;
    }
    
}

@end
