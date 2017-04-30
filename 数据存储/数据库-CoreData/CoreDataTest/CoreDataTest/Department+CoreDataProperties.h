//
//  Department+CoreDataProperties.h
//  CoreDataTest
//
//  Created by Lucky on 15/9/7.
//  Copyright © 2015年 Lucky. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Department.h"

NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *number;

@end

NS_ASSUME_NONNULL_END
