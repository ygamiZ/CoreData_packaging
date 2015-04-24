//
//  Teacher.h
//  CoreData_封装
//
//  Created by lanou3g on 15/4/8.
//  Copyright (c) 2015年 赵雪松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Teacher : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sex;

@end
