//
//  Network.m
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "Network.h"
#import "AFNetworking.h"

@implementation Network
-(void)connectTo:(NSString*)url withParams:(NSDictionary*)params byMethod:(NSString*)method{
    //设置configuration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //初始化manager
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //设置responseseriliazer
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    //初始化request
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:url parameters:nil error:nil];
    //对request进行设置
    if (params) {
        NSArray *keys = [params allKeys];
        for (int i=0; i<params.count; i++) {
            [request setValue:[params objectForYCKey:[keys objectAtYCIndex:i]] forKey:[keys objectAtYCIndex:i]];
        }
    }
    //根据request生成对应的NSURLSessionTask
    NSURLSessionTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"网络请求错误：%@",error);
        } else {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSLog(@"网络请求结果：%@",dict);
        }
    }];
    [task resume];
}
@end
