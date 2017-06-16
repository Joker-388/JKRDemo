//
//  Header.h
//  CALayerDemo
//
//  Created by Lucky on 2017/6/15.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "NSDate+JKRDate.h"
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
#import "UIColor+JKRColor.h"
#define JKRColor(r,g,b,a) [UIColor jkr_colorWithRed:r green:g blue:b alpha:a]
#define JKRColorHex(_hex_) [UIColor jkr_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#define JKRRandomColor [UIColor colorWithRed:arc4random_uniform(256.f)/255.f green:arc4random_uniform(256.f)/255.f blue:arc4random_uniform(256.f)/255.f alpha:1.f]

#endif /* Header_h */
