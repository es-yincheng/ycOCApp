//
//  Banner.h
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BannerDelegate <NSObject>

-(void)didClick:(id)data;
-(void)currentPage:(int)page total:(NSUInteger)total;

@end

@interface Banner : UIScrollView<UIScrollViewDelegate>
{
    UIButton *pic;
    bool flag;
    int scrollTopicFlag;
    NSTimer * scrollTimer;
    int currentPage;
    CGSize imageSize;
    UIImage *image;
}
@property(nonatomic,strong)NSArray * pics;
//@property(nonatomic,strong)UIImageView * tempImage;
@property(nonatomic,retain)id<BannerDelegate> bannerDelegate;
-(void)releaseTimer;
-(void)upDate;
@end
