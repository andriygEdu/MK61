//
//  Mk61Brain.m
//  MK61
//
//  Created by Andriy Gushuley on 05.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mk61Brain.h"
#import "MK61Logger.h"

@interface Mk61Brain()

@property (nonatomic, strong) NSMutableArray *stack;

@end

@implementation Mk61Brain

@synthesize stack = _stack;
@synthesize logger = _logger;

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

- (double) getPopOperand
{
    return [self popOperand];
}

- (void)pushOperand: (double)operand
{
    id value = [NSNumber numberWithDouble:operand];
    [self.stack addObject:value];
    NSLog(@"Pushed value %@ from %@", value, self.stack);
    [_logger logOperation: value];
}

- (double)performOperation: (NSString *)operation
{
    double result = 0;
    if ( [ @"+" isEqualToString:operation ] ) {
        result = self.popOperand + self.popOperand;
        [_logger logOperation: operation];
    } else if ( [ @"*" isEqualToString:operation ] ) {
        result = self.popOperand * self.popOperand; 
        [_logger logOperation: operation];
    } else if ( [ @"-" isEqualToString:operation ] ) {
        double subtractor = self.popOperand;
        result = self.popOperand - subtractor; 
        [_logger logOperation: operation];
    } else if ( [ @"/" isEqualToString:operation ] ) {
        double divider = self.popOperand;
        result = self.popOperand / divider; 
        [_logger logOperation: operation];
    } else if ( [ @"π" isEqualToString:operation ] ) { // PI
        result = M_PI;
        [_logger logOperation: operation];
    } else if ( [ @"√" isEqualToString:operation ] ) { // sqrt
        result = sqrt( self.popOperand );
        [_logger logOperation: operation];
    } else if ( [ @"sin" isEqualToString:operation ] ) {
        result = sin( self.popOperand );
        [_logger logOperation: operation];
    } else if ( [ @"cos" isEqualToString:operation ] ) {
        result = cos( self.popOperand );
        [_logger logOperation: operation];
    } else {
        return NAN;
    }
    
    [self pushOperand:result];
    
    return result;
}

- (void)clear
{
    [self.stack removeAllObjects];
    [_logger clear];
}

-(void) clearCurrent {
    [_stack removeLastObject];
}

@end
