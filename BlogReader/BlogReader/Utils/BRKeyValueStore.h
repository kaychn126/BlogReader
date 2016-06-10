//
//  EBKeyValueStore.h
//  EasyBenefitMass
//
//  Created by EasyBenefit on 15/8/18.
//  Copyright (c) 2015年 EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRKeyValueStore : NSObject
+ (BRKeyValueStore*)sharedInstance;

#pragma mark- store
- (void)putString:(NSString *)string withId:(NSString *)stringId;
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId;
- (void)putObject:(id)object withId:(NSString *)objectId;

#pragma mark- query
- (NSString *)getStringById:(NSString *)stringId;
- (NSNumber *)getNumberById:(NSString *)numberId;
- (id)getObjectById:(NSString *)objectId;

#pragma mark- delete
- (void)deleteObjectById:(NSString *)objectId;
@end
