//
//  LisztNetworking.h
//  Liszt-DownImage
//
//  Created by Liszt on 16/11/17.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 成功回调Block*/
typedef void(^LisztNetworkDownloadSuccessBlock)(id result);
/** 失败回调Block*/
typedef void(^LisztNetworkDownloadProgressBlock)(float progress);

@interface LisztNetworking : NSObject
+ (instancetype)shareNetworkDownload;
/** 网络任务进程*/
@property (strong, nonatomic) NSOperationQueue *networkQueue;
/** 并发任务个数 默认最多五个*/
@property (assign, nonatomic) NSInteger maxConcurrentOperation;

/**
 *  @param urlString 下载地址
 */
+ (void)downImageUrl:(NSString *)urlString downProgress:(LisztNetworkDownloadProgressBlock)progressBlock success:(LisztNetworkDownloadSuccessBlock)successBlock;
/**
 *  取消所有下载
 */
+ (void)cancelAllOperations;

@end
