//
//  HomeVC.m
//  mmhj
//
//  Created by cheng yin on 16/3/17.
//  Copyright © 2016年 cheng yin. All rights reserved.
//

#import "HomeVC.h"
#import "Banner.h"
#import "TempViewController.h"

@interface HomeVC ()<BannerDelegate>
{
    UIPageControl *pageView_;
}
@property (nonatomic, strong) Banner *banner;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *ActivitysArray;
@end

@implementation HomeVC

#pragma - mark 重写父类方法
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"start!");
}

-(void)createUI
{
    NSLog(@"开始创建ui！");
    
    
    
}

-(void)addUI
{
    NSLog(@"添加ui！");
    [self.view addSubview:self.banner];
    [self createActivitys:self.ActivitysArray];
}

-(void)setFrame
{
    NSLog(@"摆放ui！");
    self.banner.frame = CGRectMake(0, NAVH, SCRENW, 260*SCRENW/640);
    [self getAdvertisingData];
}

-(void)setName
{
    self.title = @"首页";
    NSLog(@"%@",self.title);
}

-(void)createActivitys:(NSArray*)activitysArray
{
    for (int i=0; i<activitysArray.count; i++) {
        NSDictionary *dict = [activitysArray objectAtYCIndex:i];
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(SCRENW/activitysArray.count*i, NAVH+260*SCRENW/640, SCRENW/activitysArray.count, SCRENW/activitysArray.count*9/10)];
        [bt setBackgroundImage:[UIImage imageNamed:[dict objectForYCKey:@"pic"]] forState:UIControlStateNormal];
//        [bt setTitle:[dict objectForYCKey:@"name"] forState:UIControlStateNormal];
        UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(SCRENW/activitysArray.count*i, CGRectGetMaxY(bt.frame), SCRENW/activitysArray.count, 30)];
        nameLb.text = [dict objectForYCKey:@"name"];
        nameLb.textAlignment = NSTextAlignmentCenter;
        nameLb.font = [UIFont systemFontOfSize:22 weight:0.1];
        bt.tag = i;
        [bt addTarget:self action:@selector(selectActivitys:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nameLb];
        [self.view addSubview:bt];
    }
}

-(IBAction)selectActivitys:(UIButton*)sender{
    NSLog(@"我选择了活动:%ld",sender.tag+1);
}

#pragma - mark - 实现协议
#pragma mark banner相关
#pragma mark -- 获取广告数据
- (void)getAdvertisingData{
    [self showAdvertising];
    [self addPageControl];
}

#pragma mark -- 显示广告
- (void)showAdvertising{
    
    //更新
    //加入数据
    NSArray *tempmarry = @[@{@"pic":@"http://ftp.darenbiji.com//advertisement/20160312/30396c53-7e07-4331-b472-a09543d30c50.png"},@{@"pic":@"http://ftp.darenbiji.com//advertisement/20160312/53f60f17-4b4f-4941-a7cc-411ba9d92d7a.png"}];
    self.banner.pics = tempmarry;
    [self.banner upDate];
    
}

#pragma mark -- 广告点击事件 点击广告事件
-(void)didClick:(id)data
{
    NSLog(@"点击：%@",data);
    //    NSString *path = [data objectForKey:@"pic"];
    //    for (int x=0; x<GetMobileHomeBannerList.count; x++) {
    //        NSDictionary *dict = GetMobileHomeBannerList[x];
    //        if ([path isEqualToString:[dict objectForKey:@"Path"]]) {
    //            PlateInfoId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"PlateInfoId"]];
    //            NotesListViewController *noteslistvc =[[NotesListViewController alloc] init];
    //            noteslistvc.dataId = PlateInfoId;
    //            noteslistvc.datatype = 2;
    //            noteslistvc.title = [Tools SafeGetString:@"Title" FromDict:dict];
    //            [self.navigationController pushViewController:noteslistvc animated:YES];
    //        }
    //    }
}

//页码
-(void)currentPage:(int)page total:(NSUInteger)total{
    if (total > 1) {
        pageView_.numberOfPages = total;
        pageView_.currentPage = page;
    }else{
        self.banner.userInteractionEnabled = NO;
        [self.banner releaseTimer];
    }
}
#pragma mark -- 初始化pageControl
- (void)addPageControl{
    //设置页码
    if (pageView_) {
        [pageView_ removeFromSuperview];
    }
    pageView_ = [[UIPageControl alloc]init];
    //设置位置
    CGFloat centerX = SCRENW * 0.5;
    CGFloat centerY = CGRectGetMaxY(self.banner.frame) - 8;
    pageView_.center =  CGPointMake(centerX, centerY);
    pageView_.bounds = CGRectMake(0, 0, 100, 20);
    //设置颜色
    pageView_.currentPageIndicatorTintColor = [UIColor redColor];
    pageView_.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view addSubview:pageView_];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark - 懒加载
-(Banner *)banner
{
    if (!_banner) {
        NSLog(@"创建banner");
        _banner = [[Banner alloc]init];
        _banner.scrollsToTop = NO;
        _banner.bannerDelegate = self;
        _banner.backgroundColor = [UIColor redColor];
    }
    return _banner;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

-(NSArray *)ActivitysArray
{
    if (!_ActivitysArray) {
        _ActivitysArray = @[@{@"pic":@"near_activity",@"name":@"附件活动"},@{@"name":@"特惠活动",@"pic":@"discount_activity"},@{@"name":@"福利闪购",@"pic":@"quickly_buy"}];
    }
    return _ActivitysArray;
}
@end
