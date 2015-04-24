//
//  CoreDataManager.m
//  CoreData_封装
//
//  Created by lanou3g on 15/4/8.
//  Copyright (c) 2015年 赵雪松. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

+ (CoreDataManager *)defaults{
    // 放置多个线程同时coredata生成多个对象
    // 当多个线程同时访问时， 会排队， 等待前者执行完成之后在执行。
    static CoreDataManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[CoreDataManager alloc] init];
    });
    return manager;
}

- (void)insertToStudent:(NSString *)name{
    // 实体结构
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    Student *student = [[Student alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    student.name = name;
    [self saveContext];
    
}

- (NSArray *)selectWithEntityName:(NSString *)EntityName attribute:(NSString *)attributeName select:(NSString *)selectName{
    // 获取查询的请求 相当于数据库中查询语句
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:EntityName];
    // 谓词检索
    // 如果全部查询， 传nil
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ == %@", attributeName, @"%@"], selectName];
    request.predicate = predicate;
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error == %@", error);
    }
    return array;
}

- (void) deleteFromEntity:(id)entityName attribute:(NSString *)attributeName select:(NSString *)selectName{
    NSArray *array = [self selectWithEntityName:entityName attribute:attributeName select:selectName];
    for (id model in array) {
        [self.managedObjectContext deleteObject:model];
    }
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lanou3g.CoreData___" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData___" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData___.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}






















@end
