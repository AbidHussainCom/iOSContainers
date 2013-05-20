//
//  DDTableView.h
//  DragDropTable
//
//  Created by Hari Kunwar on 5/18/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTableViewCell.h"

@class DDTableView;

@protocol DDTableViewDelegate <NSObject>

- (CGFloat)DDTableView:(DDTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol DDTableViewDataSource <NSObject>

@required
- (NSInteger)DDTableView:(DDTableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (DDTableViewCell *)DDTableView:(DDTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)numberOfSectionsInDDTableView:(DDTableView *)tableView;

@end

@interface DDTableView : UIView

@property (nonatomic, assign) id<DDTableViewDelegate> delegate;
@property (nonatomic, assign) id<DDTableViewDataSource> dataSource;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

@end
