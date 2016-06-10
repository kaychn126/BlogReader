//
//  BRBlogTableViewCell.m
//  BlogReader
//
//  Created by 陈凯 on 16/6/10.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import "BRBlogTableViewCell.h"
#import "BRBlogModel.h"

@interface BRBlogTableViewCell()
@property(nonatomic, retain)UIImageView *headerImageView;
@property(nonatomic, retain)UILabel *titleLabel;
@property(nonatomic, retain)UILabel *autherLabel;
@end

@implementation BRBlogTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_headerImageView];
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kRGBColor(51, 51, 51);
        _titleLabel.font = kBRFont(15);
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headerImageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(_headerImageView.mas_top);
            make.height.mas_equalTo(18);
        }];
        
        _autherLabel = [[UILabel alloc] init];
        _autherLabel.textColor = kRGBColor(151, 151, 151);
        _autherLabel.font = kBRFont(11);
        [self.contentView addSubview:_autherLabel];
        [_autherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headerImageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(6);
            make.height.mas_equalTo(12);
        }];
    }
    return self;
}

- (void)setBlogModel:(BRBlogModel *)blogModel{
    _blogModel = blogModel;
    [_headerImageView setImageWithURL:[NSURL URLWithString:_blogModel.headUrl] placeholderImage:[UIImage imageNamed:@"bloglist_header_placeholder"]];
    _titleLabel.text = _blogModel.title;
    _autherLabel.text = [NSString stringWithFormat:@"%@·%@",_blogModel.auther,_blogModel.pubDate];
    [_titleLabel sizeToFit];
    if (_titleLabel.bounds.size.height > 20) {
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headerImageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(_headerImageView.mas_top).mas_offset(-8);
            make.height.mas_equalTo(36);
        }];
        
        [_autherLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headerImageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(6);
            make.height.mas_equalTo(12);
        }];
    } else {
        [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headerImageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(_headerImageView.mas_top);
            make.height.mas_equalTo(18);
        }];
        
        [_autherLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headerImageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(12);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
