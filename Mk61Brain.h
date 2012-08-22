//
//  Mk61Brain.h
//  MK61
//
//  Created by Andriy Gushuley on 05.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MK61StackItem.h"

@protocol LogChangedDeletage
- (void) logChanged: (NSString*) log;
@end

@interface Mk61Brain : NSObject

- (void) pushValue: (double) operand;
- (void) pushValue: (double) operand andView: (NSString*) view;
- (double) performOperation: (NSString *) operation;
- (void) clear;
- (void) clearCurrent;

@end
