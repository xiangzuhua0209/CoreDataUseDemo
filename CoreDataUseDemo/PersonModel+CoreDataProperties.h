//
//  PersonModel+CoreDataProperties.h
//  CoreDataUseDemo
//
//  Created by xiangzuhua on 16/10/24.
//  Copyright © 2016年 xiangzuhua. All rights reserved.
//

#import "PersonModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PersonModel (CoreDataProperties)

+ (NSFetchRequest<PersonModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nonatomic) int64_t age;
@property (nullable, nonatomic, copy) NSString *color;

@end

NS_ASSUME_NONNULL_END
