//
//  NSDictionary+YC.h
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YC)

/**
 *  代替原NSDictionary里的objectForKey方法
 *
 *  @param aKey 传入key
 *
 *  @return 返回key对应的value
 */
- (id)objectForYCKey:(id)aKey;

@end
