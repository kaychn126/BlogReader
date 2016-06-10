//
//  NSObject+Queue.h
//  EasyBenefitMass
//
//  Created by 陈凯 on 15/7/26.
//  Copyright (c) 2015年 EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Queue)
/**
 在globalQueue中执行
 
 @param queue globalQueue
 */
- (void)executeGlobalQueue:(void (^)())queue;

/**
 在globalQueue中延迟执行
 
 @param queue   globalQueue
 @param seconds 延迟时间
 */
- (void)executeGlobalQueue:(void (^)())queue afterSeconds:(CGFloat)seconds;

/**
 在主线程中执行
 
 @param queue mainQueue
 */
- (void)executeMainQueue:(void (^)())queue;

/**
 在主线程中延迟执行
 
 @param queue   mainQueue
 @param seconds 延迟时间
 */
- (void)executeMainQueue:(void (^)())queue afterSeconds:(CGFloat)seconds;
@end
