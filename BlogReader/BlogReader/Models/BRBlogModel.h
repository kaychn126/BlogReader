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
@property(nonatomic, strong)NSString *auther;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *url;
@property(nonatomic, strong)NSString *pubDate;
@property(nonatomic, strong)NSString *headUrl;
@end
