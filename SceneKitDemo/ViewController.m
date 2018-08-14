//
//  ViewController.m
//  有形儿demo
//
//  Created by 小华 on 2018/8/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "ViewController.h"

#import <SceneKit/SceneKit.h>
#import "YXScanQRCodeController.h"
#import "SocketTool.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong)SCNView *scnView;

@property (nonatomic ,assign)CGFloat temp ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SocketTool sharedInstance].socketHost =@"192.168.2.120"; // ip
    [SocketTool sharedInstance].socketPort = 9527;// port设定
    [[SocketTool sharedInstance] cutOffSocket];
    [[SocketTool sharedInstance] socketConnectHost];
    
//    [self setupView];
    
   
}
- (IBAction)takeQR:(id)sender
{

    YXScanQRCodeController *scan = [YXScanQRCodeController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scan];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}



- (void)setupView {
    
    CGFloat ScreenW=[UIScreen mainScreen].bounds.size.width;
    CGFloat ScreenH=[UIScreen mainScreen].bounds.size.height;

    SCNView *scnView=[SCNView new];
    self.scnView=scnView;
//    scnView.allowsCameraControl = true;
    scnView.autoenablesDefaultLighting = true;
    scnView.showsStatistics = true;
    scnView.frame=CGRectMake(0 ,0 ,ScreenW, ScreenH*0.7);
    scnView.scene=[SCNScene sceneNamed:@"man1.obj"];
    [self.view addSubview:scnView];

    UIScrollView *scrollView=[UIScrollView new];
    scrollView.frame=CGRectMake(0 ,ScreenH-(ScreenH*0.3) ,ScreenW, ScreenH*0.3);
    scrollView.delegate=self;
    scrollView.contentSize=CGSizeMake(ScreenW*20, 0);
    [scrollView setContentOffset:CGPointMake((((ScreenW*20)-ScreenW)*0.5),0) animated:NO];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [scnView addGestureRecognizer:tapGesture];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog( @"%f",scrollView.contentOffset.x);
    
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

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    CGPoint p = [gestureRecognize locationInView:gestureRecognize.view];
    NSArray *hitResults = [self.scnView hitTest:p options:nil];
    
    if([hitResults count] > 0){
        SCNHitTestResult *result = hitResults.firstObject;
//        SCNNode *node = result.node;
        CGFloat x =result.localCoordinates.x;
        CGFloat y =result.localCoordinates.y;
        CGFloat z =result.localCoordinates.z;
        NSLog(@"%f--%f--%f",x,y,z);
        
    }
    

}



@end
