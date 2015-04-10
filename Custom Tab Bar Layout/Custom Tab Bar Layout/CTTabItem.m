//
//  CTTabItem.m
//  Custom Tab Bar Layout
//
//  Created by Hari Kunwar on 4/9/15.
//  Copyright (c) 2015 learning. All rights reserved.
//

#import "CTTabItem.h"

@implementation CTTabItem {
    UILabel *_tagLabel;
    UILabel *_titleLabel;
}

+ (instancetype)tabItemWithTitle:(NSString *)title image:(UIImage *)image tag:(NSUInteger)tag {
    CTTabItem *item = [CTTabItem new];
    item.title = title;
    item.imageView.image = image;
    item.tagNumber = tag;
    
    item.layer.borderColor = [UIColor redColor].CGColor;
    item.layer.borderWidth = 1.0;
    
    return item;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [UIImageView new];
        
        _tagLabel = [UILabel new];
        _tagLabel.textColor = [UIColor redColor];
        
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.imageView];
        [self addSubview:_titleLabel];
        [self addSubview:_tagLabel];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setTagNumber:(NSUInteger)tagNumber {
    _tagNumber = tagNumber;
    _tagLabel.text = [NSString stringWithFormat:@"%ld", tagNumber];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 0, y = 0, width = 0, height = 0;
    
    if (self.tagNumber == 0) {
        self.imageView.frame = self.bounds;
    }
    else {
        width = CGRectGetWidth(self.bounds);
        height = CGRectGetHeight(self.bounds);
        self.imageView.frame = CGRectMake(x, y, width, height);
        
        width = 14, height = 14, x = CGRectGetWidth(self.imageView.frame) - width;
        _tagLabel.frame = CGRectMake(x, y, width, height);
    }
    
    _titleLabel.frame = self.bounds;
}

@end
