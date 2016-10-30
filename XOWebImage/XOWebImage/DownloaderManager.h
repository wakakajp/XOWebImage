//
//  DownloaderManager.h
//  XOWebImage
//
//  Created by 哇咔咔 on 16/8/22.
//  Copyright © 2016年 jp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloaderManager : NSObject

+ (instancetype)sharedManager;
- (void)downloadWith:(NSString *)URLStr finishedBlock:(void(^)(UIImage *image))finishedBlock;
- (void)cancalDownLoadOPWithString:(NSString *)URLStr;

@end
