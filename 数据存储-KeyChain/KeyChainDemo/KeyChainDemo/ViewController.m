//
//  ViewController.m
//  KeyChainDemo
//
//  Created by 陈星妤 on 16/6/2.
//  Copyright © 2016年 陈星妤. All rights reserved.
//

#import "ViewController.h"
#import "JKRKeyChainTool.h"
#import "JKRPerson.h"
#import <Security/SecItem.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

static NSString *KEY = @"KEY";

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSString *uuidStr = [JKRKeyChainTool getUUID];
    
    JKRPerson *person = [[JKRPerson alloc] init];
    person.name = @"Joker";
    
    [JKRKeyChainTool setObject:person forKey:@"joker"];
    {
        JKRPerson *person = [JKRKeyChainTool objectForKey:@"joker"];
        NSLog(@"%@", person);
    }

    NSLog(@"%@", [JKRKeyChainTool allKeys]);
    
//    if (![JKRKeyChainTool objectForKey:KEY]) {
//        [JKRKeyChainTool setObject:uuidStr forKey:KEY];
//    }
//    //3413FFF1-01C0-40A3-A98D-D3BD9581AF74
//    NSLog(@"%@", [JKRKeyChainTool objectForKey:KEY]);
//    
//    [JKRKeyChainTool setObject:@"123123" forKey:@"JokerKeyChain"];
}

@end
