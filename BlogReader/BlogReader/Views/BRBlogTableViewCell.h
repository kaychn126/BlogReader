//
//  BRBlogTableViewCell.h
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BRBlogModel;
@interface BRBlogTableViewCell : UITableViewCell
@property(nonatomic, copy)BRBlogModel *blogModel;
@end
