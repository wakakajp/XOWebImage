//
//  DownloadOperation.h
//  XOWebImage
//
//  Created by 哇咔咔 on 16/8/21.
//  Copyright © 2016年 jp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadOperation : NSOperation

+ (instancetype)downloadOperationWithURLString:(NSString *)urlStr finishedBlock:(void (^)(UIImage *image))finishedBlock;

@end
