
//  SocketTool.m
//  SceneKitDemo
//
//  Created by 小华 on 2018/8/14.
//  Copyright © 2018年 小华. All rights reserved.
//

#import "SocketTool.h"

@implementation SocketTool

+(SocketTool *) sharedInstance
{
    static SocketTool *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[self alloc] init];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    });
    
    return sharedInstace;
}

// socket连接
-(void)socketConnectHost{
    
    self.socket =[[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError *error = nil;
    
    [self.socket connectToHost:self.socketHost onPort:self.socketPort withTimeout:-1 error:&error];
    
//    __weak typeof(self) weakSelf = self;
    
//    self.socketStartHeartBeatBlock = ^(void) {//心跳在socket工具中启动
//        [weakSelf sendHeartBeat];
//    };
    
}

// 连接成功回调
#pragma mark  - 连接成功回调
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port;
{
    NSLog(@"socket连接成功");
//    if (self.socketDidConnectToHost) {
//        self.socketDidConnectToHost(sock, host, port);
//    }
//
//    [ZSIMMonitor shareInstance];//开始监听长连接业务
//
//    NSData *sigData = [kUserDefaults valueForKey:USERSIG];
//
//    if(sigData){
//        [Zsapp_im_msg_Login_registerTool cookie123and124Block:^(int code, NSString *error) {}];
//    }
    [self.socket readDataWithTimeout:-1 tag:0];
    
}

// 切断socket
- (void)cutOffSocket
{
    NSLog(@"手动切断socket");
    
    self.socket.userData =@"SocketOfflineByUser";
    
    [self.connectTimer invalidate];
    
    [self.socket disconnect];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"socket断开连接");
    
    NSString *status=sock.userData;
    
    if ([status isEqualToString: @"SocketOfflineByUser"]) {
        // 如果由用户断开，不进行重连
        return;
    }
    else{
        [self socketConnectHost];
    }
}


// 收到数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
{
//    [self checkPacket:sock didReadData:data withTag:tag];
}

@end
