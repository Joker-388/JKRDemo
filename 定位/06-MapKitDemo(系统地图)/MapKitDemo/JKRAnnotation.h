//
//  JKRAnnotation.h
//  MapKitDemo
//
//  Created by Lucky on 15/9/10.
//  Copyright (c) 2015年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef NS_ENUM(NSInteger, JKRAnnonationType) {
    JKRAnnonationTypeAir = 0,
    JKRAnnonationTypeFood,
    JKRAnnonationTypeKTV,
    JKRAnnonationTypeHouse,
    JKRAnnonationTypeMovie
};

@interface JKRAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) JKRAnnonationType type;

@end
