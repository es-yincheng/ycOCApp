//
//  NSArray+YC.m
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "NSArray+YC.h"

@implementation NSArray (YC)

-(id)objectAtYCIndex:(NSUInteger)index
{
    if (!([self count]>index))
    {
        DEF_DEBUG(@"[数组对应的index:\"%@\"越界]", index);
        
        // 如果aKay不存在，则返回空字符串
        return @"";
    }
    
    // 返回原本key对应的value
    return [self objectAtIndex:index];
}

@end
