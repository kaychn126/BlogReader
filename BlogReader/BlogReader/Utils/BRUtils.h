//
//  BRUtils.h
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRUtils : NSObject
+ (NSString *)md5:(NSString *)srcString;

+ (void)executeGlobalQueue:(void (^)())queue;

+ (void)executeGlobalQueue:(void (^)())queue afterSeconds:(CGFloat)seconds;

+ (void)executeMainQueue:(void (^)())queue;

+ (void)executeMainQueue:(void (^)())queue afterSeconds:(CGFloat)seconds;
@end
