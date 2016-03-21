//
//  NSLogDefine.h
//  Budayang
//
//  Created by maxin on 15/10/13.
//  Copyright © 2015年 chinaPnr. All rights reserved.
//

#ifndef NSLogDefine_h
#define NSLogDefine_h


#define Dedug 1

// 日志打印
#if Dedug
#define NSLog(...) NSLog(__VA_ARGS__)
// 输出结果标记出所在类方法与行数
#define DEF_DEBUG(fmt, ...)   NSLog((@"%s[Line: %d]™ " fmt), strrchr(__FUNCTION__,'['), __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#define DEF_DEBUG(...)   {}

#endif


#endif /* NSLogDefine_h */
