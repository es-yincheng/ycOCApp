//
//  NSArray+YC.h
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YC)

/**
 *  代替原NSArray里的objectAtIndex方法
 *
 *  @param index 传入index
 *
 *  @return 返回index对应的value
 */
-(id)objectAtYCIndex:(NSUInteger)index;

@end
