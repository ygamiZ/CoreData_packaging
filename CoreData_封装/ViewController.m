//
//  ViewController.m
//  CoreData_封装
//
//  Created by lanou3g on 15/4/8.
//  Copyright (c) 2015年 赵雪松. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CoreDataManager *coreData = [CoreDataManager defaults];
    [coreData insertToStudent:@"小明"];
    NSArray *array = [coreData selectWithEntityName:@"Student" attribute:@"name" select:@"小明"];
    for (Student *stu in array) {
        NSLog(@"student == %@", stu.name);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
