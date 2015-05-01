//
//  ViewController.m
//  TestHMseg
//
//  Created by 韩扬 on 15/5/1.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "ViewController.h"
#import "HMSegmentedControl.h"
@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) HMSegmentedControl * segmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    self.segmentedControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 64, viewWidth, 50)];
    self.segmentedControl.sectionTitles = @[@"接单消息",@"发单消息",@"系统消息"];
    self.segmentedControl.selectedSegmentIndex = 1;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.tag = 3;
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, 300) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame), viewWidth, 310)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 3, 300);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(viewWidth, 0, viewWidth, 300) animated:NO];
    [self.view addSubview:self.scrollView];
    
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 310)];
    view1.backgroundColor = [UIColor redColor];
    UILabel * lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 100, 40)];
    lbl1.text = @"接单消息";
    [view1 addSubview:lbl1];
    [self.scrollView addSubview:view1];
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(viewWidth, 0, viewWidth, 310)];
    view2.backgroundColor = [UIColor yellowColor];
    UILabel * lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 100, 40)];
    lbl2.text = @"发单消息";
    [view2 addSubview:lbl2];
    [self.scrollView addSubview:view2];
    
    UIView * view3 = [[UIView alloc]initWithFrame:CGRectMake(viewWidth * 2, 0, viewWidth, 310)];
    view3.backgroundColor = [UIColor blueColor];
    UILabel * lbl3 = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 100, 40)];
    lbl3.text = @"系统消息";
    [view3 addSubview:lbl3];
    [self.scrollView addSubview:view3];
    
}
- (void)setApperanceForView:(UIView *)view {
    
//    label.backgroundColor = color;
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:21.0f];
//    label.textAlignment = NSTextAlignmentCenter;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}


@end
