//
//  APPModel.h
//  loadImage
//
//  Created by 哇咔咔 on 16/8/20.
//  Copyright © 2016年 jp. All rights reserved.
//

/*
 {
 "name" : "植物大战僵尸",
 "download" : "10311万",
 "icon" : "http:\/\/p16.qhimg.com\/dr\/48_48_\/t0125e8d438ae9d2fbb.png"
 }
 */

#import <Foundation/Foundation.h>

@interface APPModel : NSObject

@property (copy,nonatomic) NSString *name;

@property (copy,nonatomic) NSString *download;

@property (copy,nonatomic) NSString *icon;

+ (instancetype)appModelWithDict:(NSDictionary *)dict;

@end
