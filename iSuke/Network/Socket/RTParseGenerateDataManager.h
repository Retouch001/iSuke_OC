//
//  RTParseGenerateDataManager.h
//  iSuke
//
//  Created by Tang Retouch on 2018/4/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RTDeviceCommandType){
    RTDeviceCommandTypeConfig, //配置设备
    RTDeviceCommandTypeSearch, //查询设备当前运行的软件版本和硬件版本
    RTDeviceCommandTypeOnOff, //开关设备
    RTDeviceCommandTypeUpdate //远程升级设备
};


@interface RTParseGenerateDataManager : NSObject
+ (instancetype)shareInstance;
- (NSData *)configConmmandDataWithUsername:(NSString *)username psw:(NSString *)psw;
- (NSData *)searchConmmandDataWithMac:(NSString *)mac;
- (NSData *)onOffConmmandDataWithIndex:(int)index status:(BOOL)status;
- (NSData *)updateConmmandDataWithIP:(NSString *)ip port:(NSString *)port version:(NSString *)version;

- (BOOL)updateExistWithData:(NSData *)data softV:(NSString *)softV hardV:(NSString *)hardV;

@end

/*
 1.通信数据包协议格式如下：
 <STX><TYPE><LEN><DATA> <LF>
 <STX> 数据帧头，使用1字节16进制数 0x24
 <TYPE>产品类型/名称说明符,用2字节16进制数据表示，第一个字节表示智能公司产品类型序号，延续本公司其他的产品类型，第二个字节表示智能家居产品类型 0x0601
 <LEN> 数据包长度，采用1字节16进制数据 ，该长度只表示数据<DATA>的长度，不包括其他格式的数据
 <DATA>数据包，数据包
 <LF> 数据帧尾标志， 2字节16进制数据，使用0x69,0x42作为指令结束标志
 
 2、DATA数据包协议：
 <CMD><NDATA><CRC>
 <CMD> = 指令ID，一字节16进制数据，指令数据不进行任何处理。某些指令中，只有CMD而无HDATA和NDATA数据
 <NDATA> = 发送的数据内容
 <CRC> = 1字节校验和，校验和为CMD NDATA两组组数据的校验和
 
 
 3.数据包指令详细说明
 0x03 = 查询
 0x10 = 配置
 0x11 = 开启或关闭
 0x40 = 查询设备固件版本
 0x41 = 升级固件
 
 4.指令完整例子
 配置 : 24 06 01 19 10 0C 09 69 42 72 65 65 7A 65 65 2D 44 45 56 64 65 76 32 30 31 37 30 35  FF 69 42
 升级 : 24 06 01 11 41 2C 3A E8 18 D6 46   C0 A8 01 64 00 50 01 00 00 ff 69 42

 **/
