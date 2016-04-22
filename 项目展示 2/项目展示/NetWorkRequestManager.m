//
//  NetWorkRequestManager.m
//  Leisure
//
//  Created by 郭茂 on 16/3/30.
//  Copyright © 2016年 wenze. All rights reserved.
//

#import "NetWorkRequestManager.h"

@implementation NetWorkRequestManager

+ (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(RequestFinish)finish error:(RequestError)error{
    NetWorkRequestManager *manager = [[NetWorkRequestManager alloc]init];
    [manager requestWithType:type urlString:urlString parDic:parDic finish:finish error:error];
}


// 网络请求方法
- (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(RequestFinish)finish error:(RequestError)errorReq{
    // 1. 生成URL
    NSURL *url = [NSURL URLWithString:urlString];
    // 2. 创建可变的网络请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求方式 判断是不是POST
    if (type == POST) {
        // 设置请求方式
        [request setHTTPMethod:@"POST"];
        // 判断参数列表是否有值
        if (parDic.count > 0) {
            // 参数列表转化 由字典转化成data
            NSData *data = [self parDicToDataWithDic:parDic];
            // 设置请求体
            [request setHTTPBody:data];
        }
    }
    // 4 创建请求任务
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data) {
            finish(data);
        }
        if (error) {
            errorReq(error);
        }
        
    }];
    // 启动任务
    [task resume];
}


// 将参数列表格式化 key = Value&key=value
- (NSData *)parDicToDataWithDic:(NSDictionary *)dic{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    // 遍历字典,得到每一个键
    for (NSString *key in dic) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,dic[key]];
        [array addObject:str];
    }
    // 将数组中的值通过&拼接成字符串
    NSString *parString = [array componentsJoinedByString:@"&"];
    NSData *data = [parString dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}













@end
