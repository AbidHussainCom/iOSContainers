//
//  CardProtocol.h
//  CardContainer
//
//  Created by Hari Kunwar on 5/4/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CardProtocol <NSObject>

- (void)pullOutAnimated:(BOOL)animated;
- (void)pushInAnimated:(BOOL)animated;

@end
