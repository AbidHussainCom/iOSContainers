//
//  DDTableViewCell.m
//  DragDropTable
//
//  Created by Hari Kunwar on 5/18/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "DDTableViewCell.h"

@interface DDTableViewCell ()


@end

@implementation DDTableViewCell

- (id)initWithStyle:(DDTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    if(self){
        _reuseIdentifier = reuseIdentifier;
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
