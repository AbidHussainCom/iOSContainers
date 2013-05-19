//
//  DDTableViewCell.m
//  DragDropTable
//
//  Created by Hari Kunwar on 5/18/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "DDTableViewCell.h"

@implementation DDTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _textLabel.frame = [self textLabelFrame];
}

- (CGRect)textLabelFrame
{
    return self.bounds;
}

@end
