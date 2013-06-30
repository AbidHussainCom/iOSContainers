//
//  ArticleView.m
//  FlipBoard
//
//  Created by Hari Kunwar on 6/29/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "ArticleView.h"

@implementation ArticleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _headingLabel = [[UILabel alloc] init];
        _descriptionLabel = [[UILabel alloc] init];
        _imageView = [[UIImageView alloc] init];
    
        [self addSubview:_titleLabel];
        [self addSubview:_headingLabel];
        [self addSubview:_descriptionLabel];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleLabel.frame = _titleLabel.text != nil ? [self titleLabelFrame] : CGRectZero;
    _imageView.frame = _imageView.image != nil ? [self imageViewFrame] : CGRectZero;
    _headingLabel.frame = _headingLabel.text != nil ? [self headingLabelFrame] : CGRectZero;
    _descriptionLabel.frame = _descriptionLabel.text !=nil ? [self descriptionLabelFrame] : CGRectZero;
}

#pragma mark - Frame

- (CGRect)titleLabelFrame
{
    CGFloat x = 0.0f;
    CGFloat y = 20.0f;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = 20.0f;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)imageViewFrame
{
    CGFloat x = 0.0f;
    CGFloat y = CGRectGetMaxY(_titleLabel.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame)/2;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)headingLabelFrame
{
    CGFloat x = 0.0f;
    CGFloat y = CGRectGetMaxY(_imageView.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = 20.0f;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)descriptionLabelFrame
{
    CGFloat x = 0.0f;
    CGFloat y = CGRectGetMaxY(_descriptionLabel.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame) - y;
    
    return CGRectMake(x, y, width, height);
}



@end
