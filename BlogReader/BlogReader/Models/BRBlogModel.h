//
//  BRBlogModel.h
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRBlogModel : NSObject
@property(nonatomic, assign)NSInteger blogId;
@property(nonatomic, retain)NSString *auther;
@property(nonatomic, retain)NSString *title;
@property(nonatomic, retain)NSString *url;
@property(nonatomic, retain)NSString *pubDate;
@property(nonatomic, retain)NSString *headUrl;
@end
