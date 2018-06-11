//
//  RTUdpSocketManager.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/19.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTUdpSocketManager.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

static  const uint16_t Kport = 6000;

@interface RTUdpSocketManager ()<GCDAsyncUdpSocketDelegate>
@property (nonatomic, strong) GCDAsyncUdpSocket *asyncUdpSocket;
@end

@implementation RTUdpSocketManager
+ (RTUdpSocketManager *)shareInstance{
    static RTUdpSocketManager *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[RTUdpSocketManager alloc] init];
    });
    return share;
}

- (instancetype)init{
    if (self = [super init]) {
        self.asyncUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        [self bindPort];
    }
    return self;
}

- (void)bindPort{
    NSError * error = nil;
    //banding一个端口(可选),如果不绑定端口, 那么就会随机产生一个随机的电脑唯一的端口
    //端口数字范围(1024,2^16-1)
    [self.asyncUdpSocket bindToPort:8085 error:&error];
    //启用广播
    [self.asyncUdpSocket enableBroadcast:YES error:&error];
    if (error) {//监听错误打印错误信息
        NSLog(@"error:%@",error);
    }else {//监听成功则开始接收信息
        [self.asyncUdpSocket beginReceiving:&error];
    }
}

- (void)sendDataWithData:(NSData *)data{
    [self.asyncUdpSocket sendData:data toHost:[self convert255WithIp:[self getIPAddress]] port:Kport withTimeout:-1 tag:100];
}

- (void)closeUdp{
    [self.asyncUdpSocket close];
}


#pragma mark -GCDAsyncUdpSocketDelegate
-(void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag{
    if ([self.delegate respondsToSelector:@selector(udpSocket:didSendDataWithTag:)]) {
        [self.delegate udpSocket:sock didSendDataWithTag:tag];
    }
    if (tag == 100) {
        NSLog(@"表示标记为100的数据发送完成了");
    }
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(udpSocket:didNotSendDataWithTag:dueToError:)]) {
        [self.delegate udpSocket:sock didNotSendDataWithTag:tag dueToError:error];
    }
    NSLog(@"标记为tag %ld的发送失败 失败原因 %@",tag, error);
}

-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext{
    if ([self.delegate respondsToSelector:@selector(udpSocket:didReceiveData:fromAddress:withFilterContext:)]) {
        [self.delegate udpSocket:sock didReceiveData:data fromAddress:address withFilterContext:filterContext];
    }
    
    NSString *ip = [GCDAsyncUdpSocket hostFromAddress:address];
    uint16_t port = [GCDAsyncUdpSocket portFromAddress:address];
    // 继续来等待接收下一次消息
    NSLog(@"收到服务端的响应 [%@:%d] %@", ip, port, data);
    //[sock receiveOnce:nil];
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error{
    NSLog(@"udpSocket关闭");
}


#pragma mark -PrivateMethod--
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (NSString *)convert255WithIp:(NSString *)ip{
    NSMutableArray *array = (NSMutableArray *)[ip componentsSeparatedByString:@"."];
    array[3] = @"255";
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < array.count; i++) {
        if (i == 0) {
            [string appendString:array[i]];
        }else{
            [string appendString:[NSString stringWithFormat:@".%@",array[i]]];
        }
    }
    return string;
}
@end
