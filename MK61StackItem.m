//
//  MK61StackItem.m
//  MK61
//
//  Created by Andriy Gushuley on 20.08.12.
//
//

#import "MK61StackItem.h"


enum StackItemType {
    Value,
    UnaryOperation,
    BinaryOperation,
    Function,
};

@interface  MK61StackItem()

@property int type;
@property MK61StackItem* lvalue;
@property MK61StackItem* rvalue;
@property NSString* operation;
@property int priority;

@end

@implementation MK61StackItem

@synthesize value = _value;
@synthesize type = _type;
@synthesize lvalue = _lvalue;
@synthesize rvalue = _rvalue;
@synthesize operation = _operation;
@synthesize priority = _priority;

- (id) initValue: (double) value
         visible: (id) visible
{
    self = [super init];
    
    _type = Value;
    _lvalue = visible;
    _value = value;
    
    return self;
}

+ (MK61StackItem*) createValue: (double) value
                       visible: (id) visible
{
    return [[MK61StackItem alloc] initValue: value visible: visible];
}




+ (MK61StackItem*) createUnaryOperation:(NSString*) operation
                                  value: (double) value
                                operand: (MK61StackItem*) operand
{
    return [[MK61StackItem alloc] initUnaryOperation: operation value: value operand: operand];
}

- (id) initUnaryOperation: (NSString*) operation
                    value: (double) value
                  operand: (id) operand
{
    self = [super init];
    
    _type = UnaryOperation;
    _operation = operation;
    _value = value;
    _lvalue = operand;
    
    return self;
}

+ (MK61StackItem*) createBinaryOperation: (NSString*) operation
                                   value: (double) value
                                  lvalue: (MK61StackItem*) lvalue
                                  rvalue: (MK61StackItem*) rvalue
                                priority: (int) priority
{
    return [[MK61StackItem alloc] initBinaryOperation: operation
                                                value: value lvalue: lvalue rvalue: rvalue
                                             priority: priority];
}

- (id) initBinaryOperation: (NSString*) operation
                     value: (double) value
                    lvalue: (MK61StackItem*) lvalue
                    rvalue: (MK61StackItem*) rvalue
                  priority: (int) priority;
{
    self = [super init];
    
    _type = BinaryOperation;
    _value = value;
    _operation = operation;
    _lvalue = lvalue;
    _rvalue = rvalue;
    _priority = priority;
    
    return self;
}

+ (MK61StackItem*) createFunction: (NSString*) operation
                            value: (double) value
                          operand: (MK61StackItem*) operand
{
    return [[MK61StackItem alloc] initFunction: operation value: value operand: operand];
}

- (id) initFunction: (NSString*) function
              value: (double) value
            operand: (MK61StackItem*) operand
{
    self = [super init];
    
    _type = Function;
    _value = value;
    _operation = function;
    _lvalue = operand;
    
    return self;
}

- (NSString*) description
{
    switch ( _type ) {
        case Value:
            if ( _lvalue ) {
                return [_lvalue description];
            } else {
                return [NSString stringWithFormat: @"%g", _value];
            }
            break;
            
        case UnaryOperation:
        case Function:
            if ( _lvalue.type == BinaryOperation ) {
                return [NSString stringWithFormat: @"%@( %@ )", _operation, _lvalue];
            } else {
                return [NSString stringWithFormat: @"%@ %@", _operation, _lvalue];
            }
            break;
            
        case BinaryOperation: {
            id lmodified;
            if ( _lvalue.type == BinaryOperation && _lvalue.priority < _priority ) {
                lmodified = [NSString stringWithFormat: @"( %@ )", _lvalue];
            } else {
                lmodified = _lvalue;
            }
            
            id rmodified;
            if ( _rvalue.type == BinaryOperation && _rvalue.priority < _priority ) {
                rmodified = [NSString stringWithFormat: @"( %@ )", _rvalue];
            } else {
                rmodified = _rvalue;
            }
            
            return [NSString stringWithFormat: @"%@ %@ %@", lmodified, _operation, rmodified];
            break;
        }
    }
    return [NSString stringWithFormat: @"undefinined( %d, %@, %@, %@ )",
            _type, _operation, _lvalue, _rvalue];
    
}
                             
@end
