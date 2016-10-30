//
//  UIImageView+XOWebCache.m
//  XOWebImage
//
//  Created by 哇咔咔 on 16/8/24.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "UIImageView+XOWebCache.h"
#import "DownloaderManager.h"

@implementation UIImageView (XOWebCache)

- (void)xo_setImageWithURLStr:(NSString *)URLStr finishedBlock:(void(^)(UIImage *image)) finishedBlock {
    
    if (![URLStr isEqualToString:self.lastURLStr] && self.lastURLStr != nil) {
        
        [[DownloaderManager sharedManager] cancalDownLoadOPWithString:self.lastURLStr];
    }
    
    self.lastURLStr = URLStr;
    
    [[DownloaderManager sharedManager] downloadWith:URLStr finishedBlock:^(UIImage *image) {
        self.image = image;
    }];
}

@end
