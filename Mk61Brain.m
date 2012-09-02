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
@property (weak) IBOutlet id<LogChangedDeletage> logChanged;

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

- (MK61StackItem*) popOperand
{
    MK61StackItem *operand = [self.stack lastObject];
    if (operand) {
        [self.stack removeLastObject];
    }
    NSLog(@"Pop value %@ from %@", operand, self.stack);
    return operand;
}

- (void) pushOperand: (MK61StackItem*) operand
{
    [self.stack addObject: operand];
    NSLog(@"Pushed value %@ into %@", operand, self.stack);
    [self stackChanged];
}

- (void) pushValue: (double) operand
{
    [self pushValue: operand andView: nil];
}

- (void) pushValue: (double) operand andView: (NSString*) view
{
    [self pushOperand: [MK61StackItem createValue: operand visible: view]];
}

- (void) pushResult: (MK61StackItem*) result
{
    [self.stack addObject: result];
    NSLog(@"Result of operation %@ to %@", result, self.stack);
}

- (bool) popLValue: (MK61StackItem**) lvalue
         andRValue: (MK61StackItem**) rvalue
{
    *rvalue = self.popOperand;
    if ( !*rvalue ) {
        return false;
    }
    *lvalue = self.popOperand;
    if ( !*lvalue ) {
        [self pushOperand: *rvalue];
        *rvalue = nil;
        return false;
    }
    return true;
}

- (double)performOperation: (NSString *)operation
{
    MK61StackItem* lvalue;
    MK61StackItem* rvalue;
    MK61StackItem* stackValue;
    double result = 0;
    if ( [ @"+" isEqualToString: operation ] ) {
        if ( ![self popLValue: &lvalue andRValue: &rvalue] ) {
            return NAN;
        }
        result = lvalue.value + rvalue.value;
        stackValue = [MK61StackItem createBinaryOperation: operation value: result
                        lvalue: lvalue rvalue: rvalue
                        priority: MK61StackItemOperationPriorityAddition];
    } else if ( [ @"*" isEqualToString: operation ] ) {
        if ( ![self popLValue: &lvalue andRValue: &rvalue] ) {
            return NAN;
        }
        result = lvalue.value * rvalue.value;
        stackValue = [MK61StackItem createBinaryOperation: operation value: result
                                                   lvalue: lvalue rvalue: rvalue
                                                 priority: MK61StackItemOperationPriorityMultiplication];
    } else if ( [ @"-" isEqualToString: operation ] ) {
        if ( ![self popLValue: &lvalue andRValue: &rvalue] ) {
            return NAN;
        }
        result = lvalue.value - rvalue.value;
        stackValue = [MK61StackItem createBinaryOperation: operation value: result
                                                   lvalue: lvalue rvalue: rvalue
                                                 priority: MK61StackItemOperationPriorityAddition];
    } else if ( [ @"/" isEqualToString: operation ] ) {
        if ( ![self popLValue: &lvalue andRValue: &rvalue] ) {
            return NAN;
        }
        result = lvalue.value / rvalue.value;
        stackValue = [MK61StackItem createBinaryOperation: operation value: result
                                                   lvalue: lvalue rvalue: rvalue
                                                 priority: MK61StackItemOperationPriorityMultiplication];
    } else if ( [ @"π" isEqualToString: operation ] ) { // PI
        result = M_PI;
        stackValue = [MK61StackItem createValue: M_PI visible: operation];
    } else if ( [ @"√" isEqualToString: operation ] ) { // sqrt
        lvalue = [self popOperand];
        if ( !lvalue ) {
            return NAN;
        }
        result = sqrt( lvalue.value );
        stackValue = [MK61StackItem createUnaryOperation: operation value: result operand: lvalue];
    } else if ( [ @"sin" isEqualToString:operation ] ) {
        lvalue = [self popOperand];
        if ( !lvalue ) {
            return NAN;
        }
        result = sin( lvalue.value );
        stackValue = [MK61StackItem createFunction: operation value: result operand: lvalue];
    } else if ( [ @"cos" isEqualToString:operation ] ) {
        lvalue = [self popOperand];
        if ( !lvalue ) {
            return NAN;
        }
        result = cos( lvalue.value );
        stackValue = [MK61StackItem createFunction: operation value: result operand: lvalue];
    } else {
        return NAN;
    }
    
    if ( stackValue ) {
        [self pushOperand: stackValue];
    }
    
    return result;
}

- (void)clear
{
    [self.stack removeAllObjects];
    [self stackChanged];
}

-(void) clearCurrent
{
    [self popOperand];
}

- (void) stackChanged
{
    [_logChanged logChanged: [_stack componentsJoinedByString: @" "]];
}


@end
