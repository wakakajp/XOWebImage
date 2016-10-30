//
//  ViewController.m
//  XOWebImage
//
//  Created by 哇咔咔 on 16/8/20.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"
#import "AFHTTPSessionManager.h"
#import "APPModel.h"
#import "DownloaderManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (copy,nonatomic) NSString *lastURLStr;

@end

@implementation ViewController {
    NSOperationQueue *_queue;
    NSArray<APPModel *> *_appsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _queue = [[NSOperationQueue alloc] init];
    
    [self loadJsonData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_appsList) {
        int index = arc4random_uniform((u_int32_t)_appsList.count);
        
        NSString *URLStr = _appsList[index].icon;
        
        if (![URLStr isEqualToString:_lastURLStr] && _lastURLStr != nil) {
            
            [[DownloaderManager sharedManager] cancalDownLoadOPWithString:_lastURLStr];
        }
        
        DownloaderManager *manager = [DownloaderManager sharedManager];
        [manager downloadWith:URLStr finishedBlock:^(UIImage *image) {
            self.imageView.image = image;
        }];
        
        _lastURLStr = URLStr;
    }
}

- (void)loadJsonData{
    // 1. 创建网络请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // json数据的地址
    NSString *URLString = @"https://raw.githubusercontent.com/zhangxiaochuZXC/ServerFile20/master/apps.json";
    
    // 2. 网络请求管理者发送GET请求,获取json数据;
    // 默认是异步执行的,回调默认是主线程
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *responseObject) {
        
        NSLog(@"%@",responseObject);
        
        // 定义临时的可变的数组
        NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:responseObject.count];
        
        // 下一步 : 拿着字典数组responseObject,实现字典转模型
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // obj : 就是数组里的元素(字典)
            APPModel *model = [APPModel appModelWithDict:obj];
            
            // 把模型对象添加到可变数组
            [tmpM addObject:model];
        }];
        
        // 给数据源数组赋值
        _appsList = tmpM.copy;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
