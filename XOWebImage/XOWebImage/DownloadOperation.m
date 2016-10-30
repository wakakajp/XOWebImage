//
//  DownloadOperation.m
//  XOWebImage
//
//  Created by 哇咔咔 on 16/8/21.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "DownloadOperation.h"
#import "NSString+path.h"

@interface DownloadOperation ()

@property (copy,nonatomic) NSString *urlStr;

@property (copy,nonatomic) void(^finishedBlock)(UIImage *image);

@end

@implementation DownloadOperation {
    
}

+ (instancetype)downloadOperationWithURLString:(NSString *)urlStr finishedBlock:(void (^)(UIImage *image))finishedBlock {
    
    DownloadOperation *op = [[DownloadOperation alloc] init];
    
    op.urlStr = urlStr;
    op.finishedBlock = finishedBlock;
    
    return op;
}

- (void)main {
    
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    if (self.isCancelled) {
        NSLog(@"取消了");
        return;
    }
    
    if (image) {
        [data writeToFile:[_urlStr appendCachesPath] atomically:YES];
    }
    
    NSAssert(self.finishedBlock != nil, @"下载完成后回调不能为空");
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.finishedBlock(image);
    }];
}

@end
