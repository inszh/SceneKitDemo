//
//  SocketTool.h
//  SceneKitDemo
//
//  Created by 小华 on 2018/8/14.
//  Copyright © 2018年 小华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

enum{
    SocketOfflineByServer,
    SocketOfflineByUser,
};
@interface SocketTool : NSObject<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket    *socket;       // socket
@property (nonatomic, copy  ) NSString       *socketHost;   // socket的Host
@property (nonatomic, assign) UInt16         socketPort;    // socket的prot
@property (nonatomic, retain) NSTimer        *connectTimer; // 计时器
@property (nonatomic, strong) NSTimer        *locationTimer; // 上报位置的定时器
@property (nonatomic, strong) NSMutableData         *cacheData;//缓存数据

+ (SocketTool *)sharedInstance;

- (void)socketConnectHost;// socket连接

- (void)cutOffSocket;// 断开socket连接

@end
