//
//  DownloaderManager.m
//  XOWebImage
//
//  Created by 哇咔咔 on 16/8/22.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "DownloaderManager.h"
#import "DownloadOperation.h"
#import "NSString+path.h"
@interface DownloaderManager ()

@property (copy,nonatomic) NSString *lastURLStr;

@end

@implementation DownloaderManager {
    
    NSOperationQueue *_queue;
    
    NSMutableDictionary *_OPCache;
    
    DownloadOperation *_preOperation;
    
    NSMutableDictionary *_imagesCache;
}

+ (instancetype)sharedManager {
    
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _queue = [[NSOperationQueue alloc] init];
        _OPCache = [NSMutableDictionary dictionary];
        _imagesCache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)downloadWith:(NSString *)URLStr finishedBlock:(void(^)(UIImage *image))finishedBlock {
    
    if ([self isExistInMemory:URLStr]) {
        
        finishedBlock([_imagesCache objectForKey:URLStr]);
        return;
    }
    
    if ([_OPCache objectForKey:URLStr]) {
        return;
    }
    
    DownloadOperation *op = [DownloadOperation downloadOperationWithURLString:URLStr finishedBlock:^(UIImage *image) {
        
//        NSLog(@"url--%@",URLStr);
        if (image) {
            [NSThread sleepForTimeInterval:5];
            NSLog(@"我是网上的");
            finishedBlock(image);
            
            [_imagesCache setObject:image forKey:URLStr];
            [_OPCache removeObjectForKey:URLStr];
        }
    }];
    
    [_OPCache setObject:op forKey:URLStr];
    [_queue addOperation:op];
    
}

- (void)cancalDownLoadOPWithString:(NSString *)URLStr {
    
    DownloadOperation *op = [_OPCache objectForKey:URLStr];
    if (op != nil) {
        
        [op cancel];
        [_OPCache removeObjectForKey:URLStr];
    }

}

- (BOOL)isExistInMemory:(NSString *)URLStr {
    
    if ([_imagesCache objectForKey:URLStr]) {
        
        NSLog(@"我来自内存");
        return YES;
    }
    
    NSString *path = [URLStr appendCachesPath];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (image) {
        
        NSLog(@"我来自缓存");
        [_imagesCache setObject:image forKey:URLStr];
        return YES;
    }
    
    return NO;
}

@end
