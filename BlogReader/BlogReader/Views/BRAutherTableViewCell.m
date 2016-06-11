//
//  BRAutherTableViewCell.m
//  BlogReader
//
//  Created by EB on 16/6/11.
//  Copyright © 2016年 com.EasyBenefit. All rights reserved.
//

#import "BRAutherTableViewCell.h"
#import "BRAutherModel.h"

@interface BRAutherTableViewCell()
@property(nonatomic, retain)UIImageView *headerImageView;
@property(nonatomic, retain)UILabel *autherLabel;
@property(nonatomic, retain)UILabel *numberLbel;//文章数
@end

@implementation BRAutherTableViewCell

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
        
        _autherLabel = [[UILabel alloc] init];
        _autherLabel.textColor = kRGBColor(51, 51, 51);
        _autherLabel.font = kBRFont(15);
        [self.contentView addSubview:_autherLabel];
        [_autherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headerImageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(-85);
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(20);
        }];
        
        _numberLbel = [[UILabel alloc] init];
        _numberLbel.textColor = kRGBColor(151, 151, 151);
        _numberLbel.font = kBRFont(11);
        _numberLbel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_numberLbel];
        [_numberLbel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView);
            make.height.mas_equalTo(18);
            make.width.mas_equalTo(60);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAutherModel:(BRAutherModel *)autherModel{
    _autherModel = autherModel;
    [_headerImageView setImageWithURL:[NSURL URLWithString:_autherModel.headUrl] placeholderImage:[UIImage imageNamed:@"bloglist_header_placeholder"]];
    _autherLabel.text = _autherModel.auther;
    _numberLbel.text = [NSString stringWithFormat:@"%ld篇博客",(long)_autherModel.articleNumber];
}

@end
