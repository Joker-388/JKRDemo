//
//  JKRAnnotation.h
//  MKDirectionsDemo(获取导航路线信息)
//
//  Created by Lucky on 15/9/11.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef NS_ENUM(NSInteger, JKRAnnotationType) {
    JKRAnnotationTypeSource = 0,
    JKRAnnotationTypeDestination
};

@interface JKRAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) JKRAnnotationType type;

@end
