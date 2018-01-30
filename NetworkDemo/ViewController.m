//
//  ViewController.m
//  NetworkDemo
//
//  Created by wanglijun on 2018/1/16.
//  Copyright © 2018年 wanglijun. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)AFRequestSomething
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    [manager POST:@"请求地址" parameters:@"请求传参" progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestSomething
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"请求地址"]];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[NSData data];
    request.timeoutInterval=40;
    NSURLSessionDataTask *dataTask=[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [dataTask resume];
}

- (void)uploadSomething
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"上传地址"]];
    NSData *updata=[NSData data];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    NSURLSessionUploadTask *task=[manager uploadTaskWithRequest:request fromData:updata progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    [task resume];
}

- (void)resumeUploadSomething
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:@"上传地址" parameters:nil error:nil];
    
    [request setHTTPBody:[NSData data]];
    
    NSURLSessionTask *sessionTask =
    [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    
    //开始启动任务
    
    [sessionTask resume];
}

- (void)downLoadSomething
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"下载地址"]];
    NSString *fullPath=@"下载文件存储路径";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    NSURLSessionDownloadTask *task =
    [manager downloadTaskWithRequest:request
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                
                            }
                         destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                             return [NSURL fileURLWithPath:fullPath];
                         }
                   completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                       
                   }];
    [task resume];  //开始
    [task suspend]; //暂停
}

- (void)breakpointResumeDownLoadSomething
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"下载地址"]];
    
    //检查文件是否已经下载了一部分
    unsigned long long downloadedBytes = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"下载缓存路径"])
    {
        //获取已下载的文件长度
        downloadedBytes = 1;
        if (downloadedBytes > 0)
        {
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
        //不使用缓存，避免断点续传出现问题
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.securityPolicy setAllowInvalidCertificates:YES];
    [manager.securityPolicy setValidatesDomainName:NO];
    
    [manager  setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSURLResponse * _Nonnull response) {
        return NSURLSessionResponseAllow;
    } ];
    
    //下载数据回调
    [manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
        
        //存储回调的数据，自己维护一份缓存
        
        //将data写入指定的缓存路径，方便下次获取，这里写入推荐使用文件流NSFileHandle方式
        
        //NSProgress *downloadProgress=[manager downloadProgressForTask: dataTask];可以直接取到进度
        
    }];
    
    NSURLSessionDataTask *task =
    [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
    
    [task resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
