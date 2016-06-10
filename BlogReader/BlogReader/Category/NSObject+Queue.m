//
//  NSObject+Queue.m
//  EasyBenefitMass
//
//  Created by 陈凯 on 15/7/26.
//  Copyright (c) 2015年 EasyBenefit. All rights reserved.
//

#import "NSObject+Queue.h"

@implementation NSObject (Queue)
- (void)executeGlobalQueue:(void (^)())queue {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

- (void)executeGlobalQueue:(void (^)())queue afterSeconds:(CGFloat)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

- (void)executeMainQueue:(void (^)())queue {
    dispatch_async(dispatch_get_main_queue(), queue);
}

- (void)executeMainQueue:(void (^)())queue afterSeconds:(CGFloat)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), queue);
}
@end
