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

#pragma mark- queue
/**
 在globalQueue中执行
 
 @param queue globalQueue
 */
+ (void)executeGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

/**
 在globalQueue中延迟执行
 
 @param queue   globalQueue
 @param seconds 延迟时间
 */
+ (void)executeGlobalQueue:(void (^)())queue afterSeconds:(CGFloat)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

/**
 在主线程中执行
 
 @param queue mainQueue
 */
+ (void)executeMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

/**
 在主线程中延迟执行
 
 @param queue   mainQueue
 @param seconds 延迟时间
 */
+ (void)executeMainQueue:(void (^)())queue afterSeconds:(CGFloat)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), queue);
}
@end
