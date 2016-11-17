//
//  LisztDownloadOperation.m
//  Liszt-DownImage
//
//  Created by Liszt on 16/11/17.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "LisztDownloadOperation.h"
#import <UIKit/UIKit.h>

@interface LisztDownloadOperation()<NSURLSessionDelegate>
/** 下载完成回调Block*/
@property LisztNetworkDownloadSuccessBlock successBlock;
/** 下载进度跟新回调Block*/
@property LisztNetworkDownloadProgressBlock progressBlock;

@end

@implementation LisztDownloadOperation
- (instancetype)initWithUrl:(NSString *)urlString operationQueue:(NSOperationQueue *)queue progress:(LisztNetworkDownloadProgressBlock)progressBlock success:(LisztNetworkDownloadSuccessBlock)successBlock{
    self = [super init];
    if(self){
        self.successBlock = successBlock;
        self.progressBlock = progressBlock;
        
        /** 1.初始化一个Session*/
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        /** 2.设置下载代理和回调方法工作的线程 */
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:5 timeoutInterval:0];
        /** 3.发起下载任务*/
        [[session downloadTaskWithRequest:request] resume];
    }
    return self;
}

#pragma mark - <NSURLSessionDelegate>
/** 下载完成的代理*/
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [directory stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.successBlock){
            self.successBlock(path);
        }
    });
}
/** 下载进度变化的时候被调用*/
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.progressBlock){
            self.progressBlock(progress);
        }
    });
}
/** 断点续传的时候被调用的方法*/
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"LisztNetwork:断点续传触发");
}
@end
