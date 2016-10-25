//
//  ViewController.m
//  CoreDataUseDemo
//
//  Created by xiangzuhua on 16/10/24.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PersonModel+CoreDataProperties.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {

    [super viewDidLoad];
    
    //创建一个模型
    Person * p = [[Person alloc] init];
    p.name = @"刘德花";
    p.sex = @"女";
    p.age = 13;
    p.color = @"黄色";
    //存储数据到数据库
    [self addPerson:p];
    //查找数据
    [self selectPersonWithName:@"刘德花"];
    //更改数据
    [self updatePerson:p changeName:@"刘炸天"];
    //删除数据
    [self deletePerson:p];
    //删除后再查询
    [self selectPersonWithName:@"刘德花"];

}
#pragma mark -- 实现数据存储的增删改查方法
#pragma mark - 增加
-(void)addPerson:(Person*)person
{
    //初始化数据库可存储的实体对象,对应模型为Person类,放到上下文
    PersonModel * personModel = [NSEntityDescription insertNewObjectForEntityForName:@"PersonModel" inManagedObjectContext:[self context]];
    personModel.name = person.name;
    personModel.sex = person.sex;
    personModel.age = person.age;
    personModel.color = person.color;
    //保存
    [self save];
}
#pragma mark - 查找
//按照公交车名字查找
-(NSArray*)selectPersonWithName:(NSString *)name
{
    //创建搜索请求对象
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    //实体描述
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersonModel" inManagedObjectContext:[self context]];
    //给搜索请求对象添加实体描述
    [fetchRequest setEntity:entity];
    //创建谓词--即搜索条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",name];
    //给搜索请求对象设置搜索条件
    [fetchRequest setPredicate:predicate];
    //创建一个排序条件
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
    //设置搜索请求对象的排序条件 SortDescriptors是一个数组,里面存放排序条件,也就是说,排序条件可有多种,不唯一
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    //创建一个错误信息存储的对象
    NSError *error = nil;
    //执行搜索,返回的是一个存储了数据库需求的对象的数组
    NSArray *fetchedObjects = [[self context] executeFetchRequest:fetchRequest error:&error];
    //如果返回的数组内容大于0则遍历输出
    if (fetchedObjects.count > 0) {
        for (PersonModel * item in fetchedObjects) {
            NSLog(@"name = %@, age = %lld,sex = %@,color = %@",item.name,item.age,item.sex,item.color);
        }
    }
    //返回搜索结果
    return fetchedObjects;
}
#pragma mark - 删除
-(void)deletePerson:(Person*)person
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersonModel" inManagedObjectContext:[self context]];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", person.name];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age"ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError *error = nil;
    NSArray *fetchedObjects = [[self context] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count >0) {
        for (PersonModel * item in fetchedObjects) {
            [[self context] deleteObject:item];
        }
        [self save];
    }
}
#pragma mark - 修改
-(void)updatePerson:(Person*)person changeName:(NSString*)name
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersonModel" inManagedObjectContext:[self context]];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",person.name];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError *error = nil;
    NSArray *fetchedObjects = [[self context] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects.count > 0) {
        for (PersonModel * item in fetchedObjects) {
            item.name = name;
        }
    }
    [self save];
}
//获取appdelegate中的context即上下文
-(NSManagedObjectContext *)context
{
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return app.managedObjectContext;
}
//将数据保存到上下文的方法
-(void)save
{
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app saveContext];
}

@end
