//
//  EBKeyValueStore.m
//  EasyBenefitMass
//
//  Created by EasyBenefit on 15/8/18.
//  Copyright (c) 2015年 EasyBenefit. All rights reserved.
//

#import "BRKeyValueStore.h"
#import "YTKKeyValueStore.h"

@interface BRKeyValueStore()
@property(nonatomic, strong)YTKKeyValueStore *store;
@property(nonatomic, strong)NSString *tableName;
@end

@implementation BRKeyValueStore
#pragma mark- singleton

+ (BRKeyValueStore *)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[self alloc] initSingleton];
    });
    return sharedInstance;
}

- (instancetype)initSingleton{
    self = [super init];
    if(self){
        _store = [[YTKKeyValueStore alloc] initDBWithName:@"BRKeyValueStore.db"];
        _tableName = @"EBKeyValueTable";
        [_store createTableWithName:_tableName];
    }
    return self;
}

- (instancetype)init{
    return [BRKeyValueStore sharedInstance];
}

#pragma mark- store
- (void)putString:(NSString *)string withId:(NSString *)stringId{
    [_store putString:string withId:stringId intoTable:_tableName];
}
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId{
    [_store putNumber:number withId:numberId intoTable:_tableName];
}
- (void)putObject:(id)object withId:(NSString *)objectId{
    [_store putObject:object withId:objectId intoTable:_tableName];
}

#pragma mark- query
- (NSString *)getStringById:(NSString *)stringId{
    return [_store getStringById:stringId fromTable:_tableName];
}
- (NSNumber *)getNumberById:(NSString *)numberId{
    return [_store getNumberById:numberId fromTable:_tableName];
}
- (id)getObjectById:(NSString *)objectId{
    return [_store getObjectById:objectId fromTable:_tableName];
}

- (void)deleteObjectById:(NSString *)objectId{
    [_store deleteObjectById:objectId fromTable:_tableName];
}
@end
