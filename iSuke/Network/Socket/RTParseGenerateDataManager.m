//
//  RTParseGenerateDataManager.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RTParseGenerateDataManager.h"

@implementation RTParseGenerateDataManager
+ (instancetype)shareInstance{
    static RTParseGenerateDataManager *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[RTParseGenerateDataManager alloc] init];
    });
    return share;
}


#pragma mark -Generate---
- (NSData *)configConmmandDataWithUsername:(NSString *)username psw:(NSString *)psw{
    NSMutableData *totalDataM = [NSMutableData data];
    NSData *ssidData = [username dataUsingEncoding:NSUTF8StringEncoding];
    NSData *pwdData = [psw dataUsingEncoding:NSUTF8StringEncoding];
    
    Byte commendID[] = {0x10};//操作指令
    [totalDataM appendData:[NSData dataWithBytes:commendID length:1]];
    
    unsigned int ssidSize = (int)ssidData.length;
    NSData *ssidSizeData = [NSData dataWithBytes:&ssidSize length:1];
    [totalDataM appendData:ssidSizeData];
    
    unsigned int pwdSize = (int)pwdData.length;
    NSData *pwdSizeData = [NSData dataWithBytes:&pwdSize length:1];
    [totalDataM appendData:pwdSizeData];
    
    [totalDataM appendData:ssidData];
    [totalDataM appendData:pwdData];
    
    Byte endPositionByte[] = {0xff};
    [totalDataM appendData:[NSData dataWithBytes:endPositionByte length:sizeof(endPositionByte)]];
    
    return [self generateConmmandDataWithDataPacket:totalDataM];
}

- (NSData *)onOffConmmandDataWithIndex:(int)index status:(BOOL)status{
    NSMutableData *totalDataM = [NSMutableData data];
    
    Byte commendID[] = {0x11};//操作指令
    [totalDataM appendData:[NSData dataWithBytes:commendID length:1]];
    
    unsigned int indexp = index;
    NSData *indexData = [NSData dataWithBytes:&indexp length:1];
    [totalDataM appendData:indexData];
    
    unsigned int statusp = status;
    NSData *statusData = [NSData dataWithBytes:&statusp length:1];
    [totalDataM appendData:statusData];
    
    Byte endPositionByte[] = {0xff};
    [totalDataM appendData:[NSData dataWithBytes:endPositionByte length:sizeof(endPositionByte)]];

    return [self generateConmmandDataWithDataPacket:totalDataM];
}

- (NSData *)searchConmmandDataWithMac:(NSString *)mac{
    NSMutableData *totalDataM = [NSMutableData data];
    
    Byte commendID[] = {0x40};//操作指令
    [totalDataM appendData:[NSData dataWithBytes:commendID length:1]];
    
    [totalDataM appendData:[self convertHexStrToData:mac]];
    
    Byte endPositionByte[] = {0xff};
    [totalDataM appendData:[NSData dataWithBytes:endPositionByte length:sizeof(endPositionByte)]];
    
    return [self generateConmmandDataWithDataPacket:totalDataM];
}


- (NSData *)updateConmmandDataWithIP:(NSString *)ip port:(NSString *)port version:(NSString *)version{
    NSMutableData *totalDataM = [NSMutableData data];

    return totalDataM;
}



#pragma mark -PaserData----
- (BOOL)updateExistWithData:(NSData *)data softV:(NSString *)softV hardV:(NSString *)hardV{
    NSString *hardVersion = [self convertDataToHexStr:[data subdataWithRange:NSMakeRange(11, 3)]];
    NSString *softVersion = [self convertDataToHexStr:[data subdataWithRange:NSMakeRange(14, 3)]];
    
    int softDevice = [self converStringToInt:softVersion];
    int softPackage = [self converStringToInt:softV];
    
    if ([hardVersion isEqualToString:hardV] && (softPackage > softDevice)) {
        return YES;
    }
    return NO;
}

- (int)converStringToInt:(NSString *)string{
    NSArray *softArray = [string componentsSeparatedByString:@"."];
    NSMutableString *vString = [NSMutableString string];
    for (int i = 0; i<softArray.count; i++) {
        NSString *string = softArray[i];
        string = [NSString stringWithFormat:@"0%@",string];
        [vString appendString:string];
    }
    return [vString intValue];
}



#pragma mark -PrivateMethod---
- (NSData *)generateConmmandDataWithDataPacket:(NSData *)data{
    NSMutableData *totalDataM = [NSMutableData data];
    Byte firstPositionByte[] = {0x24, 0x06, 0x01};
    [totalDataM appendData:[NSData dataWithBytes:firstPositionByte length:sizeof(firstPositionByte)]];
    
    unsigned int totalSize = (int)data.length;
    NSData *totalSizeData = [NSData dataWithBytes:&totalSize length:1];
    [totalDataM appendData:totalSizeData];
    
    [totalDataM appendData:data];
    
    Byte endPositionByte[] = {0x69, 0x42};
    [totalDataM appendData:[NSData dataWithBytes:endPositionByte length:sizeof(endPositionByte)]];
    return totalDataM;
}

//16进制字符串转data
- (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

//data转16进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}


@end
