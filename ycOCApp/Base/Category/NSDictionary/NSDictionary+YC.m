//
//  NSDictionary+YC.m
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "NSDictionary+YC.h"

@implementation NSDictionary (YC)

-(id)objectForYCKey:(id)aKey
{
    if (![[self allKeys] containsObject:aKey])
    {
        DEF_DEBUG(@"[字典对应的key:\"%@\"不存在]", aKey);
        
        // 如果aKay不存在，则返回空字符串
        return @"";
    }
    
    // 返回原本key对应的value
    return [self objectForKey:aKey];
}

@end
