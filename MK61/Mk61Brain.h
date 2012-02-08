//
//  Mk61Brain.h
//  MK61
//
//  Created by Andriy Gushuley on 05.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mk61Brain : NSObject

- (void)pushOperand: (double)operand;
- (double)performOperation: (NSString *)operation;
- (void)clear;

@end
