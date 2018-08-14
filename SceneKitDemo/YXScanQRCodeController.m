//
//  YXScanQRCodeController.m
//  SceneKitDemo
//
//  Created by 小华 on 2018/8/14.
//  Copyright © 2018年 小华. All rights reserved.
//
#define LBXScan_Define_Native  //包含native库
#define LBXScan_Define_ZXing   //包含ZXing库
#define LBXScan_Define_ZBar   //包含ZBar库
#define LBXScan_Define_UI     //包含界面库

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


- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{

    LBXScanResult *scanResult = array.firstObject;
    NSString*strResult = scanResult.strScanned;
    NSArray * arrayR=[strResult componentsSeparatedByString:@"："];
    
    [SocketTool sharedInstance].socketHost =arrayR.firstObject; // ip
    NSString *port=arrayR.lastObject;
    [SocketTool sharedInstance].socketPort = port.intValue;// port设定
    [[SocketTool sharedInstance] cutOffSocket];
    [[SocketTool sharedInstance] socketConnectHost];
}



@end
