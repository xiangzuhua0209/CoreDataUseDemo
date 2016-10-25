//
//  Person.h
//  CoreDataUseDemo
//
//  Created by xiangzuhua on 16/10/24.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
//姓名
@property(nonatomic,strong)NSString * name;
//性别
@property(nonatomic,strong)NSString * sex;
//颜色
@property(nonatomic,strong)NSString * color;
//年龄
@property(nonatomic,assign)NSInteger age;

@end
