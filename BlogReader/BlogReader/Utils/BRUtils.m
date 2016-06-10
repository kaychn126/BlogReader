//
//  BRUtils.m
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import "BRUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation BRUtils
+ (NSString *)md5:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}
@end
