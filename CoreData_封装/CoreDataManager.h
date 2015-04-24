//
//  CoreDataManager.h
//  CoreData_封装
//
//  Created by lanou3g on 15/4/8.
//  Copyright (c) 2015年 赵雪松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Student.h"

@interface CoreDataManager : NSObject


// 数据管理器
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
// 数据模型器
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
// 数据链接器
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
// 保存
- (void)saveContext;
// 获取路径
- (NSURL *)applicationDocumentsDirectory;

// 单例方法初始化
+ (CoreDataManager *)defaults;

- (void)insertToStudent:(NSString *)name;

- (NSArray *)selectWithEntityName:(NSString *)EntityName attribute:(NSString *)attributeName select:(NSString *)selectName;

- (void) deleteFromEntity:(id)entityName attribute:(NSString *)attributeName select:(NSString *)selectName;




@end
