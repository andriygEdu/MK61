//
//  Mk61Brain.m
//  MK61
//
//  Created by Andriy Gushuley on 05.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mk61Brain.h"

@interface Mk61Brain()

@property (nonatomic, strong) NSMutableArray *stack;

@end

@implementation Mk61Brain

@synthesize stack = _stack;

- (NSMutableArray*) stack
{
    if (!_stack) {
        _stack = [[NSMutableArray alloc] init];
    }
    return _stack;
}

- (double) popOperand
{
    NSNumber *operand = [self.stack lastObject];
    if (operand) {
        [self.stack removeLastObject];
    }
    NSLog(@"Pop value %@ from %@", operand, self.stack);
    return [operand doubleValue];
}

- (void)pushOperand: (double)operand
{
    id value = [NSNumber numberWithDouble:operand];
    [self.stack addObject:value];
    NSLog(@"Pushed value %@ from %@", value, self.stack);
}

- (double)performOperation: (NSString *)operation
{
    double result = 0;
    if ([@"+" isEqualToString:operation]) {
        result = [self popOperand] + [self popOperand]; 
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand]; 
    } else if ([@"-" isEqualToString:operation]) {
        double subtractor = [self popOperand];
        result = [self popOperand] - subtractor; 
    } else if ([@"/" isEqualToString:operation]) {
        double divider = [self popOperand];
        result = [self popOperand] / divider; 
    } 
    
    [self pushOperand:result];
    
    return result;
}

@end
