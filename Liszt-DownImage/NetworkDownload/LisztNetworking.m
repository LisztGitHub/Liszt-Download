//
//  LisztNetworking.m
//  Liszt-DownImage
//
//  Created by Liszt on 16/11/17.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "LisztNetworking.h"
#import "LisztDownloadOperation.h"

@implementation LisztNetworking
+ (instancetype)shareNetworkDownload{
    static LisztNetworking *net = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        net = [[self alloc]init];
    });
    return net;
}

+ (void)downImageUrl:(NSString *)urlString downProgress:(LisztNetworkDownloadProgressBlock)progressBlock success:(LisztNetworkDownloadSuccessBlock)successBlock{
    LisztNetworking *network = [LisztNetworking shareNetworkDownload];
    LisztDownloadOperation *operation = [[LisztDownloadOperation alloc]initWithUrl:urlString operationQueue:network.networkQueue progress:progressBlock success:successBlock];
    [network.networkQueue addOperation:operation];
}
+ (void)cancelAllOperations{
    [[LisztNetworking shareNetworkDownload].networkQueue cancelAllOperations];
}

#pragma mark - 任务进程
- (NSOperationQueue *)networkQueue{
    if(!_networkQueue){
        _networkQueue = [[NSOperationQueue alloc]init];
    }
    _networkQueue.maxConcurrentOperationCount = [LisztNetworking shareNetworkDownload].maxConcurrentOperation==0?5:[LisztNetworking shareNetworkDownload].maxConcurrentOperation;
    return _networkQueue;
}
@end
