//
//  Banner.m
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "Banner.h"

@implementation Banner
@synthesize bannerDelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setSelf];
    }
    return self;
}
-(void)setSelf{
    self.pagingEnabled = YES;
    self.scrollEnabled = YES;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self setSelf];
    
    // Drawing code
}
-(void)upDate{
    
    for (id obj in self.subviews)  {
        if ([obj isKindOfClass:[UIView class]]) {
            UIView* theView = (UIImageView*)obj;
            [theView removeFromSuperview];
        }
    }
    
    NSMutableArray * tempImageArray = [[NSMutableArray alloc]init];
    
    [tempImageArray addObject:[self.pics lastObject]];
    for (id obj in self.pics) {
        [tempImageArray addObject:obj];
    }
    [tempImageArray addObject:[self.pics objectAtIndex:0]];
    self.pics = Nil;
    self.pics = tempImageArray;
    
    int i = 0;
    for (id obj in self.pics) {
        pic= Nil;
        
        pic = [UIButton buttonWithType:UIButtonTypeCustom];
        //        pic.backgroundColor = [UIColor colorWithRed:219/255.0 green:220/255.0 blue:221/255.0 alpha:1.0];
        //        pic.imageView.contentMode = UIViewContentModeTop;
        [pic setFrame:CGRectMake(i*self.frame.size.width,0, self.frame.size.width, self.frame.size.height)];
        UIImageView * tempImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pic.frame.size.width, pic.frame.size.height)];
        tempImage.backgroundColor = [UIColor clearColor];
        //        tempImage.contentMode = UIViewContentModeScaleAspectFill;
        [tempImage setClipsToBounds:YES];
        if ([[obj objectForKey:@"isLoc"]boolValue]) {
            [tempImage setImage:[obj objectForKey:@"pic"]];
        }else{
            //            if ([obj objectForKey:@"placeholderImage"]) {
            //                [tempImage setImage:[obj objectForKey:@"placeholderImage"]];
            //            }
            if ([obj objectForKey:@"placeholderImage"]) {
                [tempImage setImage:[UIImage imageNamed:@"imgD"]];
            } else {
                [tempImage setImage:[UIImage imageNamed:@"imgD"]];
            }
            [NSURLConnection sendAsynchronousRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[obj objectForKey:@"pic"]]]
                                               queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                   NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                                                   if (!error && responseCode == 200) {
                                                       tempImage.image = Nil;
                                                       UIImage *_img = [[UIImage alloc] initWithData:data];
                                                       [tempImage setImage:_img];
                                                   }else{
                                                       if ([obj objectForKey:@"placeholderImage"]) {
                                                           //                                                           [tempImage setImage:[obj objectForKey:@"placeholderImage"]];
                                                           [tempImage setImage:[UIImage imageNamed:@"imgD"]];
                                                       }
                                                       [tempImage setImage:[UIImage imageNamed:@"imgD"]];
                                                   }
                                               }];
        }
        tempImage.backgroundColor = WHITE;
        [pic addSubview:tempImage];
        //        [pic setBackgroundColor:[UIColor clearColor]];
        pic.tag = i;
        [pic addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = WHITE;
        pic.backgroundColor = WHITE;
        [self addSubview:pic];
        
        //文字显示
        //        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(i*self.frame.size.width, self.frame.size.height-30, self.frame.size.width,30)];
        //        [title setBackgroundColor:[UIColor blackColor]];
        //        [title setAlpha:.7f];
        //        [title setText:[NSString stringWithFormat:@" %@",[obj objectForKey:@"title"]]];
        //        [title setTextColor:[UIColor whiteColor]];
        //        [title setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        //        [self addSubview:title];
        i ++;
    }
    [self setContentSize:CGSizeMake(self.frame.size.width*[self.pics count], self.frame.size.height)];
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
        
    }
    if ([self.pics count]>3) {
        scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollTopic) userInfo:nil repeats:YES];
    }
}
-(void)click:(id)sender{
    [bannerDelegate didClick:[self.pics objectAtIndex:[sender tag]]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat Width=self.frame.size.width;
    if (scrollView.contentOffset.x == self.frame.size.width) {
        flag = YES;
    }
    if (flag) {
        if (scrollView.contentOffset.x <= 0) {
            [self setContentOffset:CGPointMake(Width*([self.pics count]-2), 0) animated:NO];
        }else if (scrollView.contentOffset.x >= Width*([self.pics count]-1)) {
            [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        }
    }
    currentPage = scrollView.contentOffset.x/self.frame.size.width-1;
    [bannerDelegate currentPage:currentPage total:[self.pics count]-2];
    scrollTopicFlag = currentPage+2==2?2:currentPage+2;
}
-(void)scrollTopic{
    [self setContentOffset:CGPointMake(self.frame.size.width*scrollTopicFlag, 0) animated:YES];
    
    if (scrollTopicFlag > [self.pics count]) {
        scrollTopicFlag = 1;
    }else {
        scrollTopicFlag++;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(scrollTopic) userInfo:nil repeats:YES];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
    }
    
}
-(void)releaseTimer{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
        
    }
}
@end
