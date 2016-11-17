//
//  LisztDownloadOperation.h
//  Liszt-DownImage
//
//  Created by Liszt on 16/11/17.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LisztNetworking.h"

@interface LisztDownloadOperation : NSOperation
/**
 *  初始化下载方法
 *  urlString 下载地址
 */
- (instancetype)initWithUrl:(NSString *)urlString operationQueue:(NSOperationQueue *)queue progress:(LisztNetworkDownloadProgressBlock)progressBlock success:(LisztNetworkDownloadSuccessBlock)successBlock;
@end
