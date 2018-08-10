//
//  ViewController.m
//  有形儿demo
//
//  Created by 小华 on 2018/8/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong)SCNView *scnView;

@property (nonatomic ,assign)CGFloat temp ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}


- (void)setupView {
    
    SCNView *scnView=[SCNView new];
    self.scnView=scnView;
    scnView.allowsCameraControl = true;
    scnView.autoenablesDefaultLighting = true;
    scnView.showsStatistics = true;
    scnView.frame=self.view.bounds;
    [self.view addSubview:scnView];
    scnView.scene=[SCNScene sceneNamed:@"man1.obj"];
    
    UIScrollView *scrollView=[UIScrollView new];
    scrollView.frame=self.view.bounds;
    scrollView.delegate=self;
    CGFloat ScreenW=[UIScreen mainScreen].bounds.size.width;
    scrollView.contentSize=CGSizeMake(ScreenW*20, 0);
    [scrollView setContentOffset:CGPointMake((((ScreenW*20)-ScreenW)*0.5),0) animated:NO];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog( @"%f",scrollView.contentOffset.x);
    
    CGFloat value =scrollView.contentOffset.x;
    
    if (self.temp>value) {
        value=0.06;
    }else{
        value=-0.06;
    }
    
    [self.scnView.scene.rootNode runAction:[SCNAction rotateByX:0 y:value z:0 duration:0]];
    value=scrollView.contentOffset.x;
    self.temp=value;
    
}


-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
}




@end
