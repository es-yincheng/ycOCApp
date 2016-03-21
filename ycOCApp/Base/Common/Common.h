//
//  Common.h
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#ifndef Common_h
#define Common_h

/**
 * 随机色
 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define GRAY [UIColor grayColor]
#define LGRAY [UIColor lightGrayColor]
#define WHITE [UIColor whiteColor]

#define SCRENW  [UIScreen mainScreen].bounds.size.width
#define SCRENH  [UIScreen mainScreen].bounds.size.height

#define NAVH 64        //导航栏高度
#define TABBAR 49      //选项卡高度
#define Radius 20       //头像圆形


#endif /* Common_h */
