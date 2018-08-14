//
//  YXScanQRCodeController.m
//  SceneKitDemo
//
//  Created by 小华 on 2018/8/14.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "YXScanQRCodeController.h"
#import "SocketTool.h"

@interface YXScanQRCodeController ()

@end

@implementation YXScanQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫描二维码";
    
}


//- (void)scanResultWithArray:(NSArray <LBXScanResult*> *)array {
//    
//    [SocketTool sharedInstance].socketHost =@"192.168.2.120"; // ip
//    [SocketTool sharedInstance].socketPort = 9527;// port设定
//    [[SocketTool sharedInstance] cutOffSocket];
//    [[SocketTool sharedInstance] socketConnectHost];
//}


@end
