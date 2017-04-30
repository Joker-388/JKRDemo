//
//  ViewController.m
//  PreferenceDemo
//
//  Created by Lucky on 15/9/24.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"

#define dataPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data.plist"]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     以键值对的方式，快速保存一个plist文件到Preferences文件里边，不需要指定位置
     保存出来的是一个字典
     */
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"Joker" forKey:@"name"];
    
    [defaults setFloat:20.00 forKey:@"age"];
    
    [defaults setBool:YES forKey:@"NB"];
    
    
    NSString *name = [defaults stringForKey:@"name"];
    CGFloat age = [defaults floatForKey:@"age"];
    BOOL isNB = [defaults boolForKey:@"NB"];
    NSLog(@"%@, %.2f, %d", name, age, isNB);
    
    /**
     UserDefaults设置数据时，不是立即写入，而是根据时间戳定时地把缓存中的数据写入本地磁盘。所以调用了set方法之后数据有可能还没有写入磁盘应用程序就终止了。出现以上问题，可以通过调用synchornize方法强制写入
     */
    
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
