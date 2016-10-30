//
//  UIImageView+XOWebCache.h
//  XOWebImage
//
//  Created by 哇咔咔 on 16/8/24.
//  Copyright © 2016年 jp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XOWebCache)

@property (copy,nonatomic) NSString *lastURLStr;

- (void)xo_setImageWithURLStr:(NSString *)URLStr finishedBlock:(void(^)(UIImage *image)) finishedBlock;

@end
