//
//  ViewController.m
//  NSKeyedArchiverDemo
//
//  Created by Lucky on 15/9/24.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import "JKRJoker.h"

#define dataPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data.archiver"]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     1,可以直接保存字符串
     2,可以直接保存数组，数组里边还可以有自定义对象，但是自定义对象必须实现NSCoding协议并实现相关方法
     3,可以直接保存字典，字典里边还可以有自定义对象，但是自定义对象必须实现NSCoding协议并实现相关方法
     4,可以保存实现了NSCoding协议的自定义对象
     5,可以直接保存NSData
     6,可以直接保存NSNumber
     */
    
//    [self saveString];
    
//    [self saveArray];
    
//    [self saveDictionary];
    
//    [self saveObject];
    
    [self saveData];
    
//    [self saveNumber];
}

- (void)saveString
{
    NSString *string = @"I am Joker!"; 
    
    NSLog(@"%@", string);
    
    [NSKeyedArchiver archiveRootObject:string toFile:dataPath];
    
    NSString *getString = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    
    NSLog(@"%@", getString);
}

- (void)saveArray
{
    JKRJoker *joker = [[JKRJoker alloc] init];
    
    joker.name = @"Joker";
    joker.age = 20;
    
    NSArray *array = @[@1, @"Joker", joker];
    
    NSLog(@"%@", array);
    
    [NSKeyedArchiver archiveRootObject:array toFile:dataPath];
    
    NSArray *getArray = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    
    NSLog(@"%@", getArray);
}

- (void)saveDictionary
{
    JKRJoker *joker = [[JKRJoker alloc] init];
    
    joker.name = @"Joker";
    joker.age = 20;
    
    NSDictionary *dict = @{@"name": @"Joker", @"age": @20, @"Person": joker};
    
    NSLog(@"%@", dict);
    
    [NSKeyedArchiver archiveRootObject:dict toFile:dataPath];
    
    NSDictionary *getDict = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    
    NSLog(@"%@", getDict);
}

- (void)saveObject
{
    JKRJoker *joker = [[JKRJoker alloc] init];
    
    joker.name = @"Joker";
    joker.age = 20;
    
    [NSKeyedArchiver archiveRootObject:joker toFile:dataPath];
    JKRJoker *getJoker = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    
    NSLog(@"%@", getJoker);
}

- (void)saveData
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"jkr" ofType:@"png"];
    
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    
    [NSKeyedArchiver archiveRootObject:data toFile:dataPath];
    
    NSData *getData = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    
    UIImage *image = [UIImage imageWithData:getData];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    
    [self.view addSubview:imageview];
}

- (void)saveNumber
{
    NSNumber *number = @666;
    
    NSLog(@"%ld", [number integerValue]);
    
    [NSKeyedArchiver archiveRootObject:number toFile:dataPath];
    
    NSNumber *getNumber = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    
    NSLog(@"%ld", [getNumber integerValue]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
