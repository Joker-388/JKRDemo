//
//  ViewController.m
//  PlistDemo
//
//  Created by Lucky on 15/9/24.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import "JKRPerson.h"

#define dataPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data.plist"]

@interface ViewController ()<UITextFieldDelegate>

{
    UITextField *_userNameTextField;
    
    UITextField *_passWorldTextField;
}

@end

@implementation ViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_passWorldTextField becomeFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     1,可直接存储字符串，但是存储的的plist文件不能用Xcode打开，但是代码里边可以读取
     2,可直接存储数组，但是数据内只能是NSString，NSNumber等
     3,可直接存储字典，但是字典里边的值只能是NSString，NSNumber等
     4,可直接存储NSData，但是存储的的plist文件不能用Xcode打开，但是代码里边可以读取
     */
    
    
    [self saveString];
//
//    [self saveArray];
    
//    [self saveDictionary];
    
//    [self saveData];
    
    }

- (void)saveString
{
    NSString *str = @"I am Joker!";
    
    NSLog(@"data to save: %@", str);
    
    [str writeToFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data.plist"] atomically:YES];
    
    NSString *getStr = [NSString stringWithContentsOfFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data.plist"]];
    
    NSLog(@"data to read: %@", getStr);
}

- (void)saveArray
{
    NSArray *array = @[@666, @"adc", @"32"];
    
    NSLog(@"data to save: %@", array);

    [array writeToFile:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data.plist"] atomically:YES];
    
    NSArray *getArray = [NSArray arrayWithContentsOfFile: [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"data.plist"]];
                         
    NSLog(@"data to read: %@", getArray);
    
}

- (void)saveDictionary
{
    NSDictionary *dict = @{@"name": @"Joker", @"age": @20};
    
    NSLog(@"data to save: %@", dict);
    
    [dict writeToFile:dataPath atomically:YES];
    
    NSDictionary *getDict = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    
    NSLog(@"data to read: %@", getDict);
    
}

- (void)saveData
{
    NSString *str = @"I am Joker";
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"data to save: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    [data writeToFile:dataPath atomically:YES];
    
    NSData *getData = [NSData dataWithContentsOfFile:dataPath];
    
    NSLog(@"data to save: %@", [[NSString alloc] initWithData:getData encoding:NSUTF8StringEncoding]);
}

- (void)saveNumber
{
    NSNumber *number = [NSNumber numberWithInteger:32];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
