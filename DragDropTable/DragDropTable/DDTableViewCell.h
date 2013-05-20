//
//  DDTableViewCell.h
//  DragDropTable
//
//  Created by Hari Kunwar on 5/18/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum DDTableViewCellStyle{
    DDTableViewCellStyleDefault
}DDTableViewCellStyle;


@interface DDTableViewCell : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *reuseIdentifier;

- (id)initWithStyle:(DDTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
