//
//  QHUser.h
//  CreateQR
//
//  Created by white on 2017/7/10.
//  Copyright © 2017年 white. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    QHUserMan,
    
} QHUserSex;

@interface QHUser : NSObject
/**
 *  姓名
 */
@property (nonatomic,   copy) NSString *name;
/**
 *  年龄
 */
@property (nonatomic, assign) NSUInteger age;
/**
 *  性别
 */
@property (nonatomic, assign) QHUserSex sex;

/**
 *  初始化方法
 *  params:
 *  name : 姓名
 *  age  : 年龄
 */
- (instancetype)initWithName:(NSString *)name
                         age:(NSUInteger)age;

/**
 *  工厂方法
 *  params:
 *  name : 姓名
 *  age  : 年龄
 */
+ (instancetype)userWithName:(NSString *)name
                         age:(NSInteger )age;


@end
