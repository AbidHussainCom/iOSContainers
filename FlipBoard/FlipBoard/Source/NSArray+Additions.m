//
//  NSArray+Additions.m
//  FlipBoard
//
//  Created by Hari Kunwar on 6/29/13.
//  Copyright (c) 2013 unknown. All rights reserved.
//

#import "NSArray+Additions.h"

@implementation NSArray (Additions)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    id object = [self count] >= index ? [self objectAtIndex:index] : nil;
    return object;
}

@end
