//
//  ViewController.m
//  CoreDataTest
//
//  Created by Lucky on 15/9/6.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Employee+CoreDataProperties.h"
#import "Department+CoreDataProperties.h"
#import "Status+CoreDataProperties.h"

@interface ViewController ()

@property (nonatomic, strong) NSManagedObjectContext *company_Context;

@property (nonatomic, strong) NSManagedObjectContext *status_Context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *createButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [createButton setTitle:@"建表" forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(createTable) forControlEvents:UIControlEventTouchUpInside];
    createButton.frame = CGRectMake(100, 50, 100, 100);
    [self.view addSubview:createButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setTitle:@"增加" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addData) forControlEvents:UIControlEventTouchUpInside];
    addButton.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:addButton];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [searchButton setTitle:@"查表" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchData) forControlEvents:UIControlEventTouchUpInside];
    searchButton.frame = CGRectMake(100, 150, 100, 100);
    [self.view addSubview:searchButton];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    deleteButton.frame = CGRectMake(100, 200, 100, 100);
    [self.view addSubview:deleteButton];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [editButton setTitle:@"修改" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editData) forControlEvents:UIControlEventTouchUpInside];
    editButton.frame = CGRectMake(100, 250, 100, 100);
    [self.view addSubview:editButton];
    
    //运行这行代码之前，是不会建表的
    [self createTable];
    
}

- (void)createTable
{
//    //获取下上文
//    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
//    
//    //模型文件
//    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
//    
//    //持久化存储调度器
//    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
//    
//    //数据库存储路径
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    
//    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"company.sqlite"];
//    
//    //数据存储的类型和路径
//    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
//    
//    context.persistentStoreCoordinator = store;
//    
//    _context = context;
    
    _company_Context = [self createContextWithName:@"Company"];
    _status_Context = [self createContextWithName:@"Status"];
    
}

- (NSManagedObjectContext *)createContextWithName:(NSString *)string
{
    //初始化上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    
    //获取模型文件的URL(安装之后的位置，模型文件安装之后后缀是.momd)
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:string withExtension:@"momd"];
    
    //获取模型文件
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    //获取模型文件的持久化存储调度器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    //获取数据库文件保存的路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", string]];
    
    //设置持久化存储调度器的属性
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    //设置上下文
    context.persistentStoreCoordinator = store;
    
    //返回上下文
    return context;
}

- (void)addData
{
//    Department *department = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:_context];
//    NSArray *array = @[@"iOS", @"Android", @"win"];
//    department.name = array[arc4random()%3];
//    department.date = [NSDate date];
//    department.number = [NSString stringWithFormat:@"NO.00%d", 1 + arc4random()%3];
//
//    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_context];
//    
//    employee.name = [NSString stringWithFormat:@"%c%c%c", 'A'+arc4random()%26,'a'+arc4random()%26,'a'+arc4random()%26];
//    employee.age = [NSNumber numberWithInt:(12 + arc4random()%30)];
//    employee.height = [NSNumber numberWithFloat:(100 + arc4random()%100)];
//    employee.department = department; 
//    
//    [_context save:nil];
    
    //建立要存储的实体类(参数1:实体类的名字。参数2:实体类要保存到哪个数据模型中)
    Department *department = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:_company_Context];
    
    //为实体类赋值
    NSArray *departmentArray = @[@"iOS", @"Android", @"win"];
    int deNO = arc4random()%3;
    department.name = departmentArray[deNO];
    department.date = [NSDate date];
    department.number = [NSString stringWithFormat:@"NO.%d", deNO + 1];
    
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_company_Context];
    employee.name = [NSString stringWithFormat:@"%c%c%c%c%c", 'A'+arc4random()%26, 'a'+arc4random()%26, 'a'+arc4random()%26, 'a'+arc4random()%26, 'a'+arc4random()%26];
    employee.height = [NSNumber numberWithFloat:(100 + arc4random()%100)];
    employee.age = [NSNumber numberWithInt:(18 + arc4random()%30)];
    employee.department = department;
    
    //所有的修改操作之后，必须保存，否则操作无效
    [_company_Context save:nil];
    
    Status *status = [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:_status_Context];
    status.name = [NSString stringWithFormat:@"%c%c%c%c%c", 'A'+arc4random()%26, 'a'+arc4random()%26, 'a'+arc4random()%26, 'a'+arc4random()%26, 'a'+arc4random()%26];
    status.text = @"Today every dreams come ture";
    
    [_status_Context save:nil];
}

- (void)searchData
{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
//    
//    //过滤查询
////    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@ and age>%d", @"Qeh", 20];
//    
////    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name endswith %@", @"t"];
//    
////    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name beginswith %@", @"A"];
//    
////    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name contains %@", @"a"];
//    
////    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@", @"*a*"];
//    
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"department.name=%@", @"iOS"];
//    
//    request.predicate = pre;
//    
//    //排序
////    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
////    request.sortDescriptors = @[sort];
//    
//    //分页
////    request.fetchLimit = 3; //每页条数
////    request.fetchOffset = 0; //起始位置
//    
//    //查找
//    NSArray *emps = [_context executeFetchRequest:request error:nil];
//    
//    NSLog(@"%@", emps);
//    
//    for (Employee *emp in emps) {
//        NSLog(@"%@-%@-%@-%@-%@-%@", emp.name, emp.age, emp.height, emp.department.name, emp.department.number, emp.department.date);
//    }
    
}

- (void)deleteData
{
//    //过滤查询（删除查询到的，不写这个全部删除）
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
//    
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@", @"Qeh"];
//    
//    request.predicate = pre;
//    
//    NSArray *emps = [_context executeFetchRequest:request error:nil];
//    
//    for (Employee *emp in emps) {
//        [_context deleteObject:emp]; //删除
//    }
//    
//    //所有操作都是暂存在内存里，要调用同步操作才能生效
//    [_context save:nil];
    
}

- (void)editData
{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
//    
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@", @"Fvt"];
//    
//    request.predicate = pre;
//    
//    NSArray *emps = [_context executeFetchRequest:request error:nil];
//    
//    for (Employee *emp in emps) {
//        emp.age = @99;
//        emp.height = @333;
//    }
//    
//    [_context save:nil];
    
}

- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
