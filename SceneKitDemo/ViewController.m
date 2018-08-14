//
//  ViewController.m
//  有形儿demo
//
//  Created by 小华 on 2018/8/7.
//  Copyright © 2018年 小华. All rights reserved.
//
#define LBXScan_Define_UI     //包含界面库

#import "ViewController.h"

#import <SceneKit/SceneKit.h>
#import "YXScanQRCodeController.h"
#import <LBXScanViewStyle.h>

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
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //扫码框中心位置与View中心位置上移偏移像素(一般扫码框在视图中心位置上方一点)
    style.centerUpOffset = 44;
    
    
    
    //扫码框周围4个角的类型设置为在框的上面,可自行修改查看效果
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    
    //扫码框周围4个角绘制线段宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角水平长度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角垂直高度
    style.photoframeAngleH = 24;
    
    
    //动画类型：网格形式，模仿支付宝
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    //动画图片:网格图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];;
    
    //扫码框周围4个角的颜色
    style.colorAngle = [UIColor colorWithRed:65./255. green:174./255. blue:57./255. alpha:1.0];
    
    //是否显示扫码框
    style.isNeedShowRetangle = YES;
    //扫码框颜色
    style.colorRetangleLine = [UIColor colorWithRed:247/255. green:202./255. blue:15./255. alpha:1.0];
    
    //非扫码框区域颜色(扫码框周围颜色，一般颜色略暗)
    //必须通过[UIColor colorWithRed: green: blue: alpha:]来创建，内部需要解析成RGBA
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    YXScanQRCodeController *scan = [YXScanQRCodeController new];
    scan.style=style;
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
