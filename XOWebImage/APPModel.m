//
//  APPModel.m
//  loadImage
//
//  Created by 哇咔咔 on 16/8/20.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "APPModel.h"

@implementation APPModel

+ (instancetype)appModelWithDict:(NSDictionary *)dict {
    
    APPModel *model = [[APPModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
